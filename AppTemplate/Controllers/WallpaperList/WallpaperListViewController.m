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

@interface WallpaperListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *datasourceArray;
@property (nonatomic) NSUInteger currentPage;

@end

@implementation WallpaperListViewController

static NSString * const reuseIdentifier = @"CollectionViewCell";
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
        [weakSelf refreshData];
        
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestNewData];
    }];
    [self refreshData];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Networking


- (void)requestData {
    _datasourceArray = @[].mutableCopy;
    [self requestNewData];
}


- (void)refreshData {
    [_datasourceArray removeAllObjects];
    _currentPage = 1;
    [self requestNewData];
}

- (void)requestNewData {
    NSDictionary *params = @{
                             @"page" : @(_currentPage),
                             @"per_page" : @30,
                             };
    [MSWallpaperData requestWallpapersDataWithAPIKey:APIClientKey parameter:params callback:^(NSArray *wallpaperDataArray, NSError *error) {
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
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.wallpaperData = _datasourceArray[indexPath.row];
    
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

@end
