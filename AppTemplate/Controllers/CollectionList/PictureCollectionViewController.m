//
//  PictureCollectionViewController.m
//  AppTemplate
//
//  Created by Monster on 31/08/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "PictureCollectionViewController.h"
#import "PicCollectionListCell.h"
#import "MJRefresh.h"
#import "MSWallpaperCollectionData.h"
#import "Common.h"
@interface PictureCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *datasourceArray;
@property (nonatomic) NSUInteger currentPage;


@end

@implementation PictureCollectionViewController

static NSString * const reuseIdentifier = @"PicCollectionListCell";
static NSInteger cellMargin = 12;


- (void)viewDidLoad {
    [super viewDidLoad];
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
        [weakSelf requestData];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestNewDataWithCompletion:^{
            
        }];
    }];
    [self refreshData];
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
    [SVProgressHUD showWithStatus:@"loading"];
    [self requestNewDataWithCompletion:^{
        [SVProgressHUD dismiss];
        
    }];
}

- (void)requestNewDataWithCompletion: (void (^)())completion{
    NSDictionary *params = @{
                             @"page" : @(_currentPage),
                             @"per_page" : @30,
                             };
    [MSWallpaperCollectionData requestWallpaperCollectionsDataWithAPIKey:APIClientKey parameter:params callback:^(NSArray *wallpaperCollectionDataArray, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"Something Bad Just Happened!"];
        }

        if ([wallpaperCollectionDataArray count]) {
            [_datasourceArray addObjectsFromArray:wallpaperCollectionDataArray];
            [_collectionView reloadData];
            _currentPage += 1;
            NSLog(@"%lu", (unsigned long)_currentPage);
            if (wallpaperCollectionDataArray.count <30) {
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


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _datasourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PicCollectionListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.wallpaperCollectionData = _datasourceArray[indexPath.row];
    
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
    NSInteger cellWidth = (CGRectGetWidth(self.collectionView.bounds) - cellMargin * 2)  ;
    return CGSizeMake(cellWidth , cellWidth * 0.66);
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
