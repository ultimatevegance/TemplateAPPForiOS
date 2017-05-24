//
//  MSPriorityCell.m
//  AppTemplate
//
//  Created by Monster on 17/05/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MSPriorityCell.h"

@implementation MSPriorityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _wrapperView.layer.cornerRadius = 8;
    _wrapperView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
