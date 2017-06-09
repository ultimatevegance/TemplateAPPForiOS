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
static NSString *mMoiveCollectionStyleCellID = @"MoiveCollectionStyleCell";
static NSInteger cellMargin = 13;

@interface MTSMoviesViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation MTSMoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView.collectionViewLayout = layout;
    [_collectionView registerNib:[UINib nibWithNibName:mMoiveCollectionStyleCellID bundle:nil] forCellWithReuseIdentifier:mMoiveCollectionStyleCellID];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.contentInset = UIEdgeInsetsMake(kScreenHeight * 0.175 - 20, 0, 0, 0);
    _collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(kScreenHeight * 0.175 - 20, 0, 0, 0);
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark - UICollectionViewDataSource
//cell config
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MoiveCollectionStyleCell *collectionStyleCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:mMoiveCollectionStyleCellID forIndexPath:indexPath];
    return  collectionStyleCell;
}
// items number for section
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
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
    CGFloat cellHeight = cellWidth * 1.64;
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
