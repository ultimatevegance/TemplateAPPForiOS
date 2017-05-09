//
//  MSBaseNavigationController.m
//  AppTemplate
//
//  Created by Monster on 09/05/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MSBaseNavigationController.h"

@interface MSBaseNavigationController ()

@end

@implementation MSBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationBar.layer.shadowRadius = 10;
    self.navigationBar.layer.shadowOpacity = 0.2;
    self.navigationBar.layer.shadowOffset = CGSizeMake(2, 2);
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
