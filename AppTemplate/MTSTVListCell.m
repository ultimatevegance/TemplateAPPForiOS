//
//  MTSTVListCell.m
//  AppTemplate
//
//  Created by MonsterSucker on 16/06/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MTSTVListCell.h"
@interface MTSTVListCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *catagoryLabel;
@end
@implementation MTSTVListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _coverImageView.layer.cornerRadius = 5;
    _coverImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
