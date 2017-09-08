//
//  CollectionDetailViewController.m
//  AppTemplate
//
//  Created by Monster on 05/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "CollectionDetailViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "CollectionViewCell.h"
#import "MSWallpaperData.h"
#import "MSWallpaperCollectionData.h"
#import "MJRefresh.h"
#import "Common.h"
#import "WallpaperDetailViewController.h"
#import "RZTransitions.h"
@interface CollectionDetailViewController ()<UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout,RZTransitionInteractionControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *datasourceArray;
@property (strong, nonatomic) NSNumber *collectionID;
@property (copy, nonatomic) NSString *collectionTitle;
@property (nonatomic, strong) id<RZTransitionInteractionController> presentInteractionController;
@property (nonatomic) NSUInteger currentPage;
@end

static NSString * const reuseIdentifier = @"CollectionViewCell";
static NSInteger cellMargin = 12;

@implementation CollectionDetailViewController

- (instancetype)initWithCollectionID:(NSNumber *)collectionID  User:(MSUserData *)user CollectionTitle:(NSString *)collectionTitle {
    self = [super init];
    if (self) {
        _collectionID = collectionID;
        _collectionTitle = collectionTitle;
    }
    return  self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.presentInteractionController = [[RZVerticalSwipeInteractionController alloc] init];
    [self.presentInteractionController setNextViewControllerDelegate:self];
    [self.presentInteractionController attachViewController:self withAction:RZTransitionAction_Present];
    // Setup the animations for presenting and dismissing a new VC
    [[RZTransitionsManager shared] setAnimationController:[[RZCirclePushAnimationController alloc] init]
                                       fromViewController:[self class]
                                                forAction:RZTransitionAction_PresentDismiss];
    _datasourceArray = [NSMutableArray array];
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(cellMargin, cellMargin, cellMargin, cellMargin);
    layout.headerHeight = 15;
    layout.footerHeight = 10;
    layout.minimumColumnSpacing = cellMargin;
    layout.minimumInteritemSpacing = cellMargin;
    
    _collectionView.collectionViewLayout = layout;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
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
    [self configTitleLabel];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //  Use the present interaction controller for presenting any view controller from this view controller
    [[RZTransitionsManager shared] setInteractionController:self.presentInteractionController
                                         fromViewController:[self class]
                                           toViewController:nil
                                                  forAction:RZTransitionAction_Present];
    
}

- (void)configTitleLabel {
    self.title = [NSString stringWithFormat:@"%@",_collectionTitle];
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
   [MSWallpaperCollectionData requestWallpaperCollectionsDataWithCollectionID:_collectionID APIKey:APIClientKey parameter:params callback:^(NSArray *wallpaperDataArray, NSError *error) {
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
    
    // Configure the cell
    
    return cell;
}


#pragma mark - CHTCollectionViewDelegateWaterfallLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSWallpaperData *wallpaperData = _datasourceArray[indexPath.row];
    CGFloat wallpaperWidth = wallpaperData.width.floatValue;
    CGFloat wallpaperHeight = wallpaperData.height.floatValue;
    return  CGSizeMake(wallpaperWidth, wallpaperHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
