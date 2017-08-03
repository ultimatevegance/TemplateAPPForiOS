//
//  MSTaskDashboardViewController.m
//  AppTemplate
//
//  Created by Monster on 08/05/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MSTaskDashboardViewController.h"
#import "MSSettingViewController.h"
#import "CollectionViewCell.h"
#import "Common.h"
@interface MSTaskDashboardViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

static NSString *dashboardCellID = @"CollectionViewCell";

@implementation MSTaskDashboardViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"dashboard"] selectedImage:[UIImage imageNamed:@"dashboard_s"]];
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"statistics"] style:UIBarButtonItemStylePlain target:self action:@selector(statics:)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStylePlain target:self action:@selector(setting:)];
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"DASHBOARD";
    self.tabBarItem.badgeValue = @"34";
    
    // 1. create UICollectionViewFlowLayout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView.collectionViewLayout = layout;
    // 2. register custom xib cell
    [self.collectionView registerNib:[UINib nibWithNibName:dashboardCellID bundle:nil] forCellWithReuseIdentifier:dashboardCellID];
    // 3. config delegate and datasource
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
}

- (void)setting:(UIBarButtonItem *)sender {
    MSSettingViewController *settingVC = [[MSSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)statics:(UIBarButtonItem *)sender {
    
}

#pragma mark - UICollectionViewDataSource
//cell config
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell bounce:NULL];
    return  cell;
}
// items number for section
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}
// sections number
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
#pragma mark - UICollectionViewDelegateFlowLayout
// cell margins
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(23, 15, 15, 15);
}
// cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger cellHeight = kScreenHeight * 0.28;
    NSInteger cellWidth = cellHeight * 0.88;
    
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
