//
//  MSPrioritySelectorView.m
//  AppTemplate
//
//  Created by Monster on 17/05/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MSPrioritySelectorView.h"
#import "MSPriorityCell.h"
#import "Common.h"
static NSString *mPriorityCellID = @"MSPriorityCell";

@interface MSPrioritySelectorView ()

@property(strong, nonatomic)NSArray *priorityTitles;
@property(strong, nonatomic)NSArray *priorityIcons;
@end
@implementation MSPrioritySelectorView 

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:mPriorityCellID bundle:nil] forCellReuseIdentifier:mPriorityCellID];
    [self configTableViewDataSource];
}

- (void)configTableViewDataSource {
    _priorityTitles = @[@"Low",@"Normal",@"High"];
    _priorityIcons = @[@"priorityLow",@"priorityNormal",@"priorityHigh"];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MSPriorityCell *cell = [_tableView dequeueReusableCellWithIdentifier:mPriorityCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = _priorityTitles[indexPath.row];
    cell.indicatorImageView.image = [UIImage imageNamed:_priorityIcons[indexPath.row]];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndexPath = indexPath;
    NSLog(@"%@",_selectedIndexPath);
    [[NSNotificationCenter defaultCenter] postNotificationName:kPrioritySelectedNotification object:_selectedIndexPath];
    
    
}
@end
