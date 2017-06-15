//
//  MTSTVShowsViewController.m
//  AppTemplate
//
//  Created by MonsterSucker on 07/06/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MTSTVShowsViewController.h"
#import "Common.h"
#import "SGPageView.h"
#import "MTSTVOnTheAirViewController.h"
#import "MTSTVTopRatedViewController.h"
#import "MTSTVPopularViewController.h"
@interface MTSTVShowsViewController ()<SGPageTitleViewDelegate, SGPageContentViewDelegare>
@property (weak, nonatomic) IBOutlet UIView *sgView;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *trendButton;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurNavBar;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;

@end

@implementation MTSTVShowsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    MTSTVOnTheAirViewController *tvOnTheAirVC = [[MTSTVOnTheAirViewController alloc] init];
    MTSTVTopRatedViewController *tvTopVC = [[MTSTVTopRatedViewController alloc] init];
    MTSTVPopularViewController *tvPopularVC = [[MTSTVPopularViewController alloc] init];
    NSArray *childArr = @[tvOnTheAirVC,tvTopVC,tvPopularVC];
    NSArray *titleArr = @[@"ON THE AIR", @"TOP", @"POPULAR"];
    
    /// pageContentView
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view insertSubview:_pageContentView belowSubview:_blurNavBar];
    
    _pageTitleView = [[SGPageTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) delegate:self titleNames:titleArr];
    [_sgView addSubview:_pageTitleView];
    _pageTitleView.isIndicatorScroll = NO;
    _pageTitleView.isTitleGradientEffect = NO;
    _pageTitleView.isShowBottomSeparator = NO;
    _pageTitleView.indicatorLengthStyle = SGIndicatorLengthTypeEqual;
    _pageTitleView.indicatorColor = PrimaryThemeColor2;
    _pageTitleView.indicatorHeight = 2;
    _pageTitleView.backgroundColor = [UIColor clearColor];
    _pageTitleView.titleColorStateNormal = PrimaryThemeColor2;
    _pageTitleView.titleColorStateSelected = PrimaryThemeColor2;

    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.tintColor = PrimaryThemeColor2;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.tintColor = PrimaryThemeColor;
}

#pragma mark - SGPAGEVIEW

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
