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
#import "SGPageView.h"
#import "MTSMoviePopularViewController.h"
#import "MTSMovieTopRatedViewController.h"
#import "MTSMovieUpcomingViewController.h"

@interface MTSMoviesViewController ()<SGPageTitleViewDelegate, SGPageContentViewDelegare>
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurTopBarView;
@property (weak, nonatomic) IBOutlet UIView *sgView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;

@end

@implementation MTSMoviesViewController

#pragma mark - LIFE CYCLE

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    MTSMoviePopularViewController *moviePopularVC = [[MTSMoviePopularViewController alloc] init];
    MTSMovieTopRatedViewController *movieTopRatedVC = [[MTSMovieTopRatedViewController alloc] init];
    MTSMovieUpcomingViewController *movieUpcomingVC = [[MTSMovieUpcomingViewController alloc] init];
    NSArray *childArr = @[moviePopularVC,movieTopRatedVC,movieUpcomingVC];
    NSArray *titleArr = @[@"POPULAR", @"TOP", @"UPCOMING"];
    
    /// pageContentView
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view insertSubview:_pageContentView belowSubview:_blurTopBarView];
    
    _pageTitleView = [[SGPageTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) delegate:self titleNames:titleArr];
    [_sgView addSubview:_pageTitleView];
    _pageTitleView.isIndicatorScroll = NO;
    _pageTitleView.isTitleGradientEffect = NO;
    _pageTitleView.isShowBottomSeparator = NO;
    _pageTitleView.indicatorLengthStyle = SGIndicatorLengthTypeEqual;
    _pageTitleView.indicatorColor = PrimaryThemeColor;
    _pageTitleView.indicatorHeight = 2;
    _pageTitleView.backgroundColor = [UIColor clearColor];
    _pageTitleView.titleColorStateNormal = PrimaryThemeColor;
    _pageTitleView.titleColorStateSelected = PrimaryThemeColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

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
