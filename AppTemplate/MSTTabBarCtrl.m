//
//  MSTTabBarCtrl.m
//  AppTemplate
//
//  Created by MonsterSucker on 20/03/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MSTTabBarCtrl.h"
#import "Common.h"
#import "MSTaskHomeViewController.h"
#import "MSTaskDashboardViewController.h"
#import "MSBigAddButton.h"
@interface MSTTabBarCtrl ()

@end

@implementation MSTTabBarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configCenterAddButton];
    [self setupViewControllers];
}

- (void)setupViewControllers {
    MSTaskHomeViewController *taskHomeVC = [[MSTaskHomeViewController alloc] init];
    UINavigationController *taskHomeNav = [[UINavigationController alloc] initWithRootViewController:taskHomeVC];
    MSTaskDashboardViewController *taskDashboardVC = [[MSTaskDashboardViewController alloc] init];
    UINavigationController *taskDashboardNav = [[UINavigationController alloc] initWithRootViewController:taskDashboardVC];
    
    [self setViewControllers:@[taskHomeNav,taskDashboardNav] animated:YES];
    self.selectedIndex  = 0;

}

- (void)configCenterAddButton {
    MSBigAddButton *addButton = [MSBigAddButton buttonWithType:UIButtonTypeCustom];
    [addButton setFrame:CGRectMake(0, 0, kScreenWidth * 0.15, kScreenWidth * 0.15)];
    [addButton setImage:[UIImage imageNamed:@"addIcon"] forState:UIControlStateNormal];
    CGPoint center = CGPointMake(self.tabBar.center.x, self.tabBar.center.y - CGRectGetHeight(self.tabBar.frame) / 2);
    addButton.center = center;
    [addButton setBackgroundColor:PrimaryThemeColor];
    [self.view addSubview:addButton];
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
