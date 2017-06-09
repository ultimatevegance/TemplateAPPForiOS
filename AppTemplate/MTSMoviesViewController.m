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



@end

#pragma mark - LIFE CYCLE
@implementation MTSMoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [_collectionView registerNib:[UINib nibWithNibName:mMoiveCollectionStyleCellID bundle:nil] forCellWithReuseIdentifier:mMoiveCollectionStyleCellID];
    _collectionView.collectionViewLayout = layout;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.contentInset = UIEdgeInsetsMake(kScreenHeight * 0.175 - 20, 0, 0, 0);
    _collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(kScreenHeight * 0.175 - 20, 0, 0, 0);

    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestNewData];
    }];

    _segmentCtrl.sectionTitles = @[@"POPULAR",@"LATEST",@"UPCOMING"];
    _segmentCtrl.backgroundColor = [UIColor clearColor];
    _segmentCtrl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentCtrl.selectionIndicatorHeight = 2.f;
    _segmentCtrl.selectionIndicatorColor = PrimaryThemeColor;
    _segmentCtrl.titleTextAttributes = @{NSForegroundColorAttributeName : PrimaryThemeColor,NSFontAttributeName :UISegmentControlFont};
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    _currentPage = 1;
    [self requestData];

}

#pragma mark - DATA PARSING

- (void)requestData {
    _movies = [NSMutableArray array];
    _movies = @[].mutableCopy;
    [self requestNewData];
}

- (void)refreshData {
    [_movies removeAllObjects];
    _currentPage = 1;
    [self requestNewData];
}

- (void)requestNewData {
    [[JLTMDbClient sharedAPIInstance] GET:kJLTMDbMoviePopular withParameters:@{@"page" : @(_currentPage)} andResponseBlock:^(id response, NSError *error) {
        if (response) {
            _currentPage = [[response objectForKey:@"page"] integerValue];
            _currentPage += 1;
            NSArray *requestedMovies = [MTLJSONAdapter modelsOfClass:[MTSMovieData class] fromJSONArray:response[@"results"] error:&error];
            if ([requestedMovies count]) {
                [_movies addObjectsFromArray:requestedMovies];
            }
        }
        [_collectionView reloadData];
        [_collectionView.mj_footer endRefreshing];
        [_collectionView.mj_header endRefreshing];
    }];
}

#pragma mark - UICollectionViewDataSource
//cell config
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MoiveCollectionStyleCell *collectionStyleCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:mMoiveCollectionStyleCellID forIndexPath:indexPath];
    collectionStyleCell.movieData = _movies[indexPath.row];
    return  collectionStyleCell;
}
// items number for section
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _movies.count;
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
