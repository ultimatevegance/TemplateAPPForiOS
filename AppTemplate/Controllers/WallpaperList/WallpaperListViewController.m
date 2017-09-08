//
//  WallpaperListViewController.m
//  AppTemplate
//
//  Created by Monster on 31/08/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "WallpaperListViewController.h"
#import "CollectionViewCell.h"
#import "Common.h"
#import "MJRefresh.h"
#import "MSWallpaperData.h"
#import "WallpaperDetailViewController.h"
#import "RZTransitions.h"
#import "ForceTouchPreviewController.h"
@interface WallpaperListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,RZTransitionInteractionControllerDelegate,UIViewControllerPreviewingDelegate>

@property (strong, nonatomic) NSMutableArray *datasourceArray;
@property (nonatomic) NSUInteger currentPage;
@property (nonatomic, strong) id<RZTransitionInteractionController> presentInteractionController;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic, strong)NSIndexPath *selectedIndexPath;

@end

@implementation WallpaperListViewController

static NSString * const reuseIdentifier = @"CollectionViewCell";
static NSInteger cellMargin = 12;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Create the presentation interaction controller that allows a custom gesture
    // to control presenting a new VC via a presentViewController
    self.presentInteractionController = [[RZVerticalSwipeInteractionController alloc] init];
    [self.presentInteractionController setNextViewControllerDelegate:self];
    [self.presentInteractionController attachViewController:self withAction:RZTransitionAction_Present];
    // Setup the animations for presenting and dismissing a new VC
    [[RZTransitionsManager shared] setAnimationController:[[RZCirclePushAnimationController alloc] init]
                                       fromViewController:[self class]
                                                forAction:RZTransitionAction_PresentDismiss];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    _datasourceArray = [NSMutableArray array];
    self.collectionView.contentInset = UIEdgeInsetsMake( 68 , 0, 0, 0);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = [ UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
        
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestNewDataWithCompletion:^{
            
        }];
    }];
    [self refreshData];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //  Use the present interaction controller for presenting any view controller from this view controller
    [[RZTransitionsManager shared] setInteractionController:self.presentInteractionController
                                         fromViewController:[self class]
                                           toViewController:nil
                                                  forAction:RZTransitionAction_Present];

}

#pragma mark - Networking

- (void)requestData {
    _datasourceArray = @[].mutableCopy;
    [self requestNewDataWithCompletion:^{
        
    }];
}

- (void)refreshData {
    [_datasourceArray removeAllObjects];
    _currentPage = 1;
    [SVProgressHUD showWithStatus:@"Loading"];
    [self requestNewDataWithCompletion:^{
        [SVProgressHUD dismissWithDelay:0.3];

    }];
}

- (void)requestNewDataWithCompletion: (void (^)())completion{
    NSDictionary *params = @{
                             @"page" : @(_currentPage),
                             @"per_page" : @30,
                             };
    [MSWallpaperData requestWallpapersDataWithAPIKey:APIClientKey parameter:params callback:^(NSArray *wallpaperDataArray, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"Something Bad Just Happened!"];
        }
        if ([wallpaperDataArray count]) {
            [_datasourceArray addObjectsFromArray:wallpaperDataArray];
            [_collectionView reloadData];
            _currentPage += 1;
            NSLog(@"%lu", (unsigned long)_currentPage);
            if (wallpaperDataArray.count <30) {
                _collectionView.mj_footer.hidden = YES;
            } else {
                _collectionView.mj_footer.hidden = NO;
            }

        }
        completion();
        [_collectionView.mj_footer endRefreshing];
        [_collectionView.mj_header endRefreshing];
    }];

}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndexPath = indexPath;
    CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    MSWallpaperData *selectedCellData = _datasourceArray[indexPath.row];
    WallpaperDetailViewController *detailedVC = [[WallpaperDetailViewController alloc] initWithSourceImage:cell.wallpaper DownloadUrl:selectedCellData.urls_full User:selectedCellData.user] ;
    
    if (cell.wallpaper) {
        [self setTransitioningDelegate:[RZTransitionsManager shared]];
        [detailedVC setTransitioningDelegate:[RZTransitionsManager shared]];
        RZVerticalSwipeInteractionController *dismissInteractionController = [[RZVerticalSwipeInteractionController alloc] init];
        [dismissInteractionController attachViewController:detailedVC withAction:RZTransitionAction_Dismiss];
        [[RZTransitionsManager shared] setInteractionController:dismissInteractionController
                                             fromViewController:[self class]
                                               toViewController:nil
                                                      forAction:RZTransitionAction_Dismiss];

        [self presentViewController:detailedVC animated:YES completion:nil];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _datasourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.wallpaperData = _datasourceArray[indexPath.row];
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        
        [self registerForPreviewingWithDelegate:(id)self sourceView:cell];
    }
    
    // Configure the cell
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
// cell margins
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(cellMargin, cellMargin, cellMargin, cellMargin);
}
// cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger cellWidth = (CGRectGetWidth(self.collectionView.bounds) - cellMargin * 4) / 3 ;
    return CGSizeMake(cellWidth , cellWidth * 1.7);
}

# pragma mark - 3D Touch Delegate

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    
    // check if we're not already displaying a preview controller
    if ([self.presentedViewController isKindOfClass:[ForceTouchPreviewController class]]) {
        return nil;
    }
    
    CollectionViewCell *cell = (CollectionViewCell *)previewingContext.sourceView;
    MSWallpaperData *selectedCellData = cell.wallpaperData;
    
    ForceTouchPreviewController *fPreviewVC = [[ForceTouchPreviewController alloc] initWithSourceImage:cell.wallpaper DownloadUrl:selectedCellData.urls_full User:selectedCellData.user];
    return fPreviewVC;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    CollectionViewCell *cell = (CollectionViewCell *)previewingContext.sourceView;
    MSWallpaperData *selectedCellData = cell.wallpaperData;
    WallpaperDetailViewController *detailedVC = [[WallpaperDetailViewController alloc] initWithSourceImage:cell.wallpaper DownloadUrl:selectedCellData.urls_full User:selectedCellData.user] ;
    [self setTransitioningDelegate:[RZTransitionsManager shared]];
    [detailedVC setTransitioningDelegate:[RZTransitionsManager shared]];
    RZVerticalSwipeInteractionController *dismissInteractionController = [[RZVerticalSwipeInteractionController alloc] init];
    [dismissInteractionController attachViewController:detailedVC withAction:RZTransitionAction_Dismiss];
    [[RZTransitionsManager shared] setInteractionController:dismissInteractionController
                                         fromViewController:[self class]
                                           toViewController:nil
                                                  forAction:RZTransitionAction_Dismiss];

    [self presentViewController:detailedVC animated:YES completion:nil];
    // alternatively, use the view controller that's being provided here (viewControllerToCommit)
}

@end
