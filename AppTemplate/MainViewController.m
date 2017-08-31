//
//  MainViewController.m
//  AppTemplate
//
//  Created by MonsterSucker on 31/08/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MainViewController.h"
#import "Common.h"
#import "WallpaperListViewController.h"
#import "PictureCollectionViewController.h"
@interface MainViewController ()<TYTabPagerControllerDataSource, TYTabPagerControllerDelegate>
@property (nonatomic, strong) NSArray *pageTitles;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    [self configureTabButtonPager];
    [self configurePagerStyles];
    self.navigationItem.titleView = self.tabBar.layout.pagerTabBar;
    
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}

- (void)configurePagerStyles
{
    self.tabBarHeight = 30;
}

- (void)configureTabButtonPager
{
    self.dataSource = self;
    self.delegate = self;
    _pageTitles = @[@"Wallpapers",@"Collections"];
    self.tabBar.layout.barStyle = TYPagerBarStyleProgressBounceView;
    self.tabBar.layout.normalTextFont = [UIFont systemFontOfSize:15];
    self.tabBar.layout.selectedTextFont = [UIFont systemFontOfSize:15];
    self.tabBar.backgroundColor = [UIColor greenColor];
    self.tabBar.layout.progressColor = [UIColor redColor];
    self.tabBar.layout.normalTextColor = [UIColor flatGrayColorDark ];
    self.tabBar.layout.selectedTextColor = [UIColor flatRedColor];
    self.tabBar.layout.cellWidth = 40;
    self.tabBar.layout.cellEdging = 20;
    self.tabBar.layout.cellSpacing = 0;
    [self.tabBar.layout.pagerTabBar setContentInset:UIEdgeInsetsMake(0, 50, 0, 50)];
}

#pragma mark - TYPagerControllerDataSource

- (NSInteger)numberOfControllersInTabPagerController
{
    return _pageTitles.count;
}

- (NSString *)tabPagerController:(TYTabPagerController *)tabPagerController titleForIndex:(NSInteger)index
{
    return _pageTitles[index];
}
- (UIViewController *)tabPagerController:(TYTabPagerController *)tabPagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching
{
    if (index == 0) {
        
        WallpaperListViewController *wallpaperListVC = [[WallpaperListViewController alloc] init];
        return wallpaperListVC;
        
    } else {
        PictureCollectionViewController *pictureCollectionsVC = [[PictureCollectionViewController alloc] init];
        return pictureCollectionsVC;
 
    }
    
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
