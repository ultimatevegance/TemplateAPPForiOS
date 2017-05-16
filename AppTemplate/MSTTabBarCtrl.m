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
#import "MSTaskCreateViewController.h"
#import "MSBigAddButton.h"
#import <YPBubbleTransition.h>
#import "MSBaseNavigationController.h"
#import "MSTaskEditorViewController.h"
@interface MSTTabBarCtrl ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) YPBubbleTransition *transition;
@property (nonatomic, strong) MSBigAddButton *addTaskButton;
@property (nonatomic, assign) CGRect buttonFrame;
@end

@implementation MSTTabBarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTabbarAppearance];
    [self configCenterAddButton];
    [self setupViewControllers];
}

- (void)configTabbarAppearance {
    self.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(2, 2);
    self.tabBar.layer.shadowOpacity = 0.5;
    self.tabBar.layer.shadowRadius = 10;
}

- (void)setupViewControllers {
    MSTaskHomeViewController *taskHomeVC = [[MSTaskHomeViewController alloc] init];
    MSBaseNavigationController *taskHomeNav = [[MSBaseNavigationController alloc] initWithRootViewController:taskHomeVC];
    MSTaskDashboardViewController *taskDashboardVC = [[MSTaskDashboardViewController alloc] init];
    MSBaseNavigationController *taskDashboardNav = [[MSBaseNavigationController alloc] initWithRootViewController:taskDashboardVC];
    
    [self setViewControllers:@[taskHomeNav,taskDashboardNav] animated:YES];
    self.selectedIndex  = 0;

}

- (void)configCenterAddButton {
    //不要复写draw 方法来加圆角和阴影 最好写一个UIview的拓展
    _addTaskButton = [MSBigAddButton buttonWithType:UIButtonTypeCustom];
    [_addTaskButton setFrame:CGRectMake(0, 0, kScreenWidth * 0.15, kScreenWidth * 0.15)];
    _addTaskButton.layer.cornerRadius = CGRectGetHeight(_addTaskButton.frame) / 2;
    _addTaskButton.layer.shadowColor = PrimaryThemeColor.CGColor;
    _addTaskButton.layer.shadowOffset = CGSizeMake(0, 8);
    _addTaskButton.layer.shadowOpacity = 0.6;
    _addTaskButton.layer.shadowRadius = 6;
    [_addTaskButton setImage:[UIImage imageNamed:@"addIcon"] forState:UIControlStateNormal];
    _addTaskButton.tintColor = [UIColor whiteColor];
    CGPoint center = CGPointMake(self.tabBar.center.x, self.tabBar.center.y - CGRectGetHeight(self.tabBar.frame) / 2);
    [_addTaskButton addTarget: self action:@selector(addButtonClickd:) forControlEvents:UIControlEventTouchUpInside];
    _addTaskButton.center = center;
    _buttonFrame = _addTaskButton.frame;
    [_addTaskButton setBackgroundColor:PrimaryThemeColor];
    [self.view addSubview:_addTaskButton];
}

- (void)addButtonClickd:(UIButton *)sender {
//    MSTaskCreateViewController *taskCreateVC = [[MSTaskCreateViewController alloc] initWithButtonFrame:_buttonFrame];
//    taskCreateVC.transitioningDelegate = self;
    MSTaskEditorViewController *taskEditorVC = [[MSTaskEditorViewController alloc] init];
    taskEditorVC.buttonFrame = _buttonFrame;
    taskEditorVC.transitioningDelegate = self;
    [self presentViewController:taskEditorVC animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.transition.transitionMode = YPBubbleTransitionModePresent;
    self.transition.startPoint = _addTaskButton.center;
    self.transition.bubbleColor = _addTaskButton.backgroundColor;
    return self.transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.transition.transitionMode = YPBubbleTransitionModeDismiss;
    self.transition.startPoint = _addTaskButton.center;
    self.transition.bubbleColor = _addTaskButton.backgroundColor;
    return self.transition;
}


- (YPBubbleTransition *)transition
{
    if (!_transition) {
        _transition = [[YPBubbleTransition alloc] init];
        _transition.duration = 0.25f;
    }
    return _transition;
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
