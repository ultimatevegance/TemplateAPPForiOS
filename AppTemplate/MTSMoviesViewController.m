//
//  MTSMoviesViewController.m
//  AppTemplate
//
//  Created by MonsterSucker on 07/06/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MTSMoviesViewController.h"
#import "MoiveCollectionStyleCell.h"
#import "Common.h"
#import "HMSegmentedControl.h"

static NSString *mMoiveCollectionStyleCellID = @"MoiveCollectionStyleCell";
static NSInteger cellMargin = 13;

@interface MTSMoviesViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet HMSegmentedControl *segmentCtrl;
@property (strong, nonatomic) NSMutableArray *movies;
@property (assign, nonatomic) NSInteger currentPage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *colums;
@property (strong, nonatomic) NSArray *dataSourceArray;
@property (strong, nonatomic) NSArray *collectionViews;
@property (assign, nonatomic) NSInteger columnIndex;

@end

#pragma mark - LIFE CYCLE
@implementation MTSMoviesViewController

- (void)setColumnIndex:(NSInteger)columnIndex {
    _columnIndex = columnIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    [_collectionView registerNib:[UINib nibWithNibName:mMoiveCollectionStyleCellID bundle:nil] forCellWithReuseIdentifier:mMoiveCollectionStyleCellID];
//    _collectionView.collectionViewLayout = layout;
//    _collectionView.delegate = self;
//    _collectionView.dataSource = self;
//    _collectionView.contentInset = UIEdgeInsetsMake(kScreenHeight * 0.175 - 20, 0, 0, 0);
//    _collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(kScreenHeight * 0.175 - 20, 0, 0, 0);
//
//    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self refreshData];
//    }];
//    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [self requestNewData];
//    }];
    
    _colums = @[kJLTMDbMoviePopular,kJLTMDbMovieTopRated,kJLTMDbMovieUpcoming];
    NSMutableArray *popularDataSource = [NSMutableArray array];
    NSMutableArray *latestDataSource = [NSMutableArray array];
    NSMutableArray *upcomingDataSource = [NSMutableArray array];
    _dataSourceArray = @[popularDataSource,latestDataSource,upcomingDataSource];
    
    _segmentCtrl.sectionTitles = @[@"POPULAR",@"TOP",@"UPCOMING"];
    _segmentCtrl.backgroundColor = [UIColor clearColor];
    _segmentCtrl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentCtrl.selectionIndicatorHeight = 2.f;
    _segmentCtrl.selectionIndicatorColor = PrimaryThemeColor;
    _segmentCtrl.titleTextAttributes = @{NSForegroundColorAttributeName : PrimaryThemeColor,NSFontAttributeName :UISegmentControlFont};
    [_segmentCtrl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    _segmentCtrl.selectedSegmentIndex = 0;
    _columnIndex = _segmentCtrl.selectedSegmentIndex;
    
    _scrollView.pagingEnabled = YES;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(kScreenWidth * _colums.count, kScreenHeight);
    
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < _colums.count; i ++) {
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.contentInset = UIEdgeInsetsMake(kScreenHeight * 0.175 - 20, 0, 0, 0);
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(kScreenHeight * 0.175 - 20, 0, 0, 0);
        [collectionView registerNib:[UINib nibWithNibName:mMoiveCollectionStyleCellID bundle:nil] forCellWithReuseIdentifier:mMoiveCollectionStyleCellID];
        collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [self refreshData];
            }];
        collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self requestData];
            }];

        [tempArray addObject:collectionView];
        [_scrollView addSubview:collectionView];
    }
    _collectionViews = [NSArray arrayWithArray:tempArray];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    _currentPage = 1;
    [self requestNewDataWithColumnIndex:_columnIndex];
}

#pragma mark - HELPERS

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}

#pragma mark - UIScrollViewDelegate
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = _scrollView.contentOffset.x / pageWidth;
    NSLog(@"%ld", (long)page);
    _columnIndex = page;
    NSLog(@"%ld", (long)_columnIndex);
    
    [_segmentCtrl setSelectedSegmentIndex:page animated:YES];
    [self requestNewDataWithColumnIndex:_columnIndex];
}


#pragma mark - DATA PARSING

- (void)requestData {
    NSMutableArray *dataSource = [_dataSourceArray objectAtIndex:_columnIndex];
    dataSource = @[].mutableCopy;
    [self requestNewDataWithColumnIndex:_columnIndex];
}

- (void)refreshData {
    NSMutableArray *dataSource = [_dataSourceArray objectAtIndex:_columnIndex];
    [dataSource removeAllObjects];
    _currentPage = 1;
    [self requestNewDataWithColumnIndex:_columnIndex];
}

- (void)requestNewDataWithColumnIndex:(NSInteger)columnIndex {
    NSLog(@"%@", _colums[columnIndex]);
    [[JLTMDbClient sharedAPIInstance] GET:_colums[columnIndex] withParameters:@{@"page" : @(_currentPage)} andResponseBlock:^(id response, NSError *error) {
        if (response) {
            _currentPage = [[response objectForKey:@"page"] integerValue];
            _currentPage += 1;
            NSArray *requestedMovies = [MTLJSONAdapter modelsOfClass:[MTSMovieData class] fromJSONArray:response[@"results"] error:&error];
            if ([requestedMovies count]) {
                [_dataSourceArray[columnIndex] addObjectsFromArray:requestedMovies];
            }
        }
        UICollectionView *collectionViewAtColumnIndex = [_collectionViews objectAtIndex:columnIndex];
        [collectionViewAtColumnIndex reloadData];
        [collectionViewAtColumnIndex.mj_footer endRefreshing];
        [collectionViewAtColumnIndex.mj_header endRefreshing];
    }];
}

#pragma mark - UICollectionViewDataSource
//cell config
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MoiveCollectionStyleCell *collectionStyleCell = [collectionView dequeueReusableCellWithReuseIdentifier:mMoiveCollectionStyleCellID forIndexPath:indexPath];
    NSMutableArray *columnDataSource = _dataSourceArray[_columnIndex];
    collectionStyleCell.movieData = columnDataSource[indexPath.row];
    return  collectionStyleCell;
}
// items number for section
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSMutableArray *columnDataSource = _dataSourceArray[_columnIndex];
    return columnDataSource.count;
}
// sections number
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
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
    CGFloat cellWidth = (kScreenWidth - cellMargin * 4) / 3;
    CGFloat cellHeight = cellWidth * 1.80;
    return CGSizeMake(cellWidth, cellHeight);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
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
