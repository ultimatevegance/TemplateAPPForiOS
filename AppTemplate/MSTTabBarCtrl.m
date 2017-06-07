//
//  MSTTabBarCtrl.m
//  AppTemplate
//
//  Created by MonsterSucker on 20/03/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MSTTabBarCtrl.h"
#import "Common.h"
#import "MTSMoviesViewController.h"
#import "MTSTVShowsViewController.h"
#import "MTSWatchListViewController.h"
#import "MTSProfileViewController.h"
@interface MSTTabBarCtrl ()

@end

@implementation MSTTabBarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
}

- (void)setupViewControllers {
    //movies
    MTSMoviesViewController *movies = [[MTSMoviesViewController alloc] init];
    movies.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Movies" image:[UIImage imageNamed:@"movies"] selectedImage:[UIImage imageNamed:@"movies"]];
    movies.view.backgroundColor = PrimaryBackgroundColor ;
    UINavigationController *moviesNav = [[UINavigationController alloc] initWithRootViewController:movies];
    //TV Shows
    MTSTVShowsViewController *tvShows = [[MTSTVShowsViewController alloc] init];
    tvShows.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"TV Shows" image:[UIImage imageNamed:@"tvShows"] selectedImage:[UIImage imageNamed:@"tvShows"]];
    tvShows.view.backgroundColor = PrimaryBackgroundColor;
        UINavigationController *tvShowsNav = [[UINavigationController alloc] initWithRootViewController:tvShows];
    //watchlist
    MTSWatchListViewController *watchlist = [[MTSWatchListViewController alloc] init];
    watchlist.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Watchlist" image:[UIImage imageNamed:@"watchList"] selectedImage:[UIImage imageNamed:@"watchList"]];
    watchlist.view.backgroundColor = PrimaryBackgroundColor;
        UINavigationController *watchlistNav = [[UINavigationController alloc] initWithRootViewController:watchlist];
    //profiles
    MTSProfileViewController *profile = [[MTSProfileViewController alloc] init];
    profile.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[UIImage imageNamed:@"profile"] selectedImage:[UIImage imageNamed:@"profile"]];
    profile.view.backgroundColor = PrimaryBackgroundColor;
    UINavigationController *profileNav = [[UINavigationController alloc] initWithRootViewController:profile];

    [self setViewControllers:@[moviesNav,tvShowsNav,watchlistNav,profileNav] animated:YES];
    self.selectedIndex  = 0;
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
