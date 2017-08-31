//
//  MSMainViewController.m
//  AppTemplate
//
//  Created by Monster on 31/08/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MSMainViewController.h"
#import "SGPageView.h"
#import "PictureCollectionViewController.h"
#import "PictureListCollectionViewController.h"
#import "WallpaperListViewController.h"
#import "Common.h"

@interface MSMainViewController () <SGPageTitleViewDelegate, SGPageContentViewDelegare>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@end

@implementation MSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    /// pageTitleView
    NSArray *titleArray = @[@"Wallpapers",@"Collections"];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.6, 44) delegate:self titleNames:titleArray];
    self.navigationItem.titleView  = _pageTitleView;
    
    _pageTitleView.isShowIndicator = YES;
    _pageTitleView.isShowBottomSeparator = NO;
    _pageTitleView.titleTextScaling = 0.2;
    _pageTitleView.indicatorLengthStyle = SGIndicatorLengthTypeDefault;
    _pageTitleView.titleColorStateNormal = [UIColor grayColor];
    _pageTitleView.isTitleGradientEffect = NO;
    _pageTitleView.backgroundColor = [UIColor clearColor];
    _pageTitleView.selectedIndex = 0;
    _pageTitleView.isNeedBounces = NO;
    _pageTitleView.isOpenTitleTextZoom = YES;
    
    /// pageContentView
    
    PictureCollectionViewController *picCollectionVC = [[PictureCollectionViewController alloc] init];
    WallpaperListViewController *wallpapersListVC = [[WallpaperListViewController alloc] init];
    NSArray *childArray = @[wallpapersListVC,picCollectionVC];
    
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:self.view.bounds parentVC:self childVCs:childArray];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];

}

- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}

- (void)SGPageContentView:(SGPageContentView *)SGPageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
