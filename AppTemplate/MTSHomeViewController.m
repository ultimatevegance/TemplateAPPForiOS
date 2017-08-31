//
//  MTSHomeViewController.m
//  AppTemplate
//
//  Created by MonsterSucker on 01/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MTSHomeViewController.h"
#import "SGPagingView.h"
#import "Common.h"

#import "WallpaperListViewController.h"
#import "PictureCollectionViewController.h"

@interface MTSHomeViewController ()<SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@end

@implementation MTSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    /// pageTitleView
    NSArray *titleArray = @[@"Wallpapers",@"Collections"];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.6, 44) delegate:self titleNames:titleArray];
    self.navigationItem.titleView  = _pageTitleView;
    _pageTitleView.isShowIndicator = YES;
    _pageTitleView.isShowBottomSeparator = NO;
    _pageTitleView.titleTextScaling = 0.2;
    _pageTitleView.indicatorLengthStyle = SGIndicatorLengthStyleDefault;
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
    
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) parentVC:self childVCs:childArray];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];


}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];

}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex{
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];

}

@end
