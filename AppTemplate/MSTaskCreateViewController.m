//
//  MSTaskCreateViewController.m
//  AppTemplate
//
//  Created by MonsterSucker on 08/05/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MSTaskCreateViewController.h"
#import "Common.h"
#import "MSBigAddButton.h"
@interface MSTaskCreateViewController ()
@property (nonatomic, assign) CGRect buttonFrame;
@property (nonatomic, strong) MSBigAddButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *lable;

@end

@implementation MSTaskCreateViewController
- (instancetype)initWithButtonFrame:(CGRect)buttonFrame {
    self = [super init];
    if (self) {
        _buttonFrame = buttonFrame;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_lable bounce:NULL];
    self.view .backgroundColor = PrimaryThemeColor;
    [self setNeedsStatusBarAppearanceUpdate];
    _cancelButton = [MSBigAddButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setFrame:_buttonFrame];
    _cancelButton.layer.cornerRadius = CGRectGetHeight(_cancelButton.frame) / 2;
    _cancelButton.tintColor = PrimaryThemeColor;
    [_cancelButton setImage:[UIImage imageNamed:@"addIcon"] forState:UIControlStateNormal];
    [_cancelButton addTarget: self action:@selector(cancelButtonClickd:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_cancelButton];
    
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

- (void)cancelButtonClickd:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
