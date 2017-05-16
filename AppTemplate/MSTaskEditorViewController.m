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

@interface MSTaskEditorViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MSBigAddButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *taskCreateBoardView;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIImageView *projectImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *projectTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *taskTitleTextView;
@property (weak, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (strong, nonatomic)NSArray *taskSettingTitles;
@property (strong, nonatomic)NSArray *taskSettingIcons;

@end

static NSString *mTableViewCellID = @"TaskSettingCell";

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
    _projectImageView.layer.cornerRadius = CGRectGetHeight(_projectImageView.frame) / 2;
    _projectImageView.layer.masksToBounds = YES;
    
    _createButton.layer.cornerRadius = CGRectGetHeight(_createButton.frame) / 2;
    _createButton.layer.masksToBounds = YES;
    
    [self configTableView];

}

- (void)configTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:mTableViewCellID];
    _taskSettingTitles = @[@"Due Date",@"Proirity",@"Reminder"];
    _taskSettingIcons = @[@"dueIcon",@"priorityIcon",@"reminderIcon"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:mTableViewCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.textLabel setText:_taskSettingTitles[indexPath.row]];
    cell.textLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:15];
    [cell.imageView setImage:[UIImage imageNamed:_taskSettingIcons[indexPath.row]]];
    switch (indexPath.row) {
        case 0:
        {
            UILabel *dueDateLabel = [[UILabel alloc] init];
            dueDateLabel.textAlignment = NSTextAlignmentRight;
            dueDateLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:12];
            dueDateLabel.frame = CGRectMake(0, 0, 100, 30);
            [dueDateLabel setText:@"2018-12-23 10:12"];
            dueDateLabel.textColor = PrimaryThemeColor;
            cell.accessoryView = dueDateLabel;
            break;
        }
        case 1:
        {
            UIImageView *priorityImageView = [[UIImageView alloc] init];
            priorityImageView.frame = CGRectMake(0, 0, 27, 27);
            [priorityImageView setImage:[UIImage imageNamed:@"priorityHigh"]];
            cell.accessoryView = priorityImageView;
            break;
        
        }
        case 2:
        {
            UILabel *reminderLabel = [[UILabel alloc] init];
            reminderLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:12];
            reminderLabel.textAlignment = NSTextAlignmentRight;
            reminderLabel.textColor = [UIColor darkGrayColor];
            reminderLabel.frame = CGRectMake(0, 0, 100, 30);
            [reminderLabel setText:@"Never"];
            reminderLabel.textColor = PrimaryThemeColor;
            cell.accessoryView = reminderLabel;

            break;
            
        }
    
        default:
            break;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _taskSettingTitles.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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
