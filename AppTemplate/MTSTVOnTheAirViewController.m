//
//  MTSTVOnTheAirViewController.m
//  AppTemplate
//
//  Created by MonsterSucker on 16/06/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MTSTVOnTheAirViewController.h"
#import "MTSTVListCell.h"
#import "Common.h"
static NSString *mMTSTVListCellId = @"MTSTVListCell";
@interface MTSTVOnTheAirViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MTSTVOnTheAirViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.estimatedRowHeight = 116;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.contentInset = UIEdgeInsetsMake(kScreenHeight * 0.175, 0, 0, 0);
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kScreenHeight * 0.175, 0, 0, 0);

    [_tableView registerNib:[UINib nibWithNibName:mMTSTVListCellId bundle:nil] forCellReuseIdentifier:mMTSTVListCellId];
    
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MTSTVListCell *tvCell = [_tableView dequeueReusableCellWithIdentifier:mMTSTVListCellId forIndexPath:indexPath];
    tvCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return tvCell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
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
