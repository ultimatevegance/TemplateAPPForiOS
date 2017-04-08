//
//  MSTTabBarCtrl.m
//  AppTemplate
//
//  Created by MonsterSucker on 20/03/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MSTTabBarCtrl.h"
#import "Common.h"
#import "MTSViewController1.h"
#import "MTSViewController2.h"
#import "MTSViewController3.h"
@interface MSTTabBarCtrl ()

@end

@implementation MSTTabBarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
}

- (void)setupViewControllers {
    MTSViewController1 *vc1 = [[MTSViewController1 alloc] init];
    vc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:[UIImage imageNamed:@"home"] selectedImage:[UIImage imageNamed:@"home_s"]];
    vc1.view.backgroundColor = [UIColor flatBlackColorDark] ;
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    
    MTSViewController2 *vc2 = [[MTSViewController2 alloc] init];
    vc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Lab" image:[UIImage imageNamed:@"lab"] selectedImage:[UIImage imageNamed:@"lab_s"]];
    vc2.view.backgroundColor = [UIColor flatBlackColorDark];
        UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    
    MTSViewController3 *vc3 = [[MTSViewController3 alloc] init];
    vc3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Discover" image:[UIImage imageNamed:@"shirt"] selectedImage:[UIImage imageNamed:@"shirt_s"]];
    vc3.view.backgroundColor = [UIColor flatBlackColorDark];
        UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    
    [self setViewControllers:@[nav1,nav2,nav3] animated:YES];
    self.selectedIndex  = 0;
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSFontAttributeName:[UIFont fontWithName:@"Advent Pro" size:13.0f]
                                                        } forState:UIControlStateNormal];

    
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
