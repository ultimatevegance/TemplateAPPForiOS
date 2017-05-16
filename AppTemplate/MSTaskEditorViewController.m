//
//  MSTaskEditorViewController.m
//  AppTemplate
//
//  Created by Monster on 16/05/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MSTaskEditorViewController.h"
#import "MSBigAddButton.h"
#import "Common.h"

@interface MSTaskEditorViewController ()
@property (nonatomic, strong) MSBigAddButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *taskCreateBoardView;
@end

@implementation MSTaskEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];

}

- (void)setUpUI {
    //sell.view appearance
    self.view.backgroundColor = PrimaryThemeColor;
    self.view.layer.cornerRadius = 8;
    self.view.layer.masksToBounds = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    //cancel button
    _cancelButton = [MSBigAddButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setFrame:_buttonFrame];
    _cancelButton.layer.cornerRadius = CGRectGetHeight(_cancelButton.frame) / 2;
    _cancelButton.tintColor = PrimaryThemeColor;
    [_cancelButton setImage:[UIImage imageNamed:@"addIcon"] forState:UIControlStateNormal];
    [_cancelButton addTarget: self action:@selector(cancelButtonClickd:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_cancelButton];
    //task create board
    _taskCreateBoardView.layer.cornerRadius = 8;
    _taskCreateBoardView.layer.masksToBounds = YES;
    [_taskCreateBoardView pulse:NULL];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.5f animations:^{
        _cancelButton.transform = CGAffineTransformMakeRotation(-M_PI_4*3.0f);
    }];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [UIView animateWithDuration:0.5f animations:^{
        _cancelButton.transform = CGAffineTransformIdentity;
    }];
    
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)cancelButtonClickd:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
