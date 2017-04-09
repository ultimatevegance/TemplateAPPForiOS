//
//  MTSProjectTableViewCell.m
//  AppTemplate
//
//  Created by MonsterSucker on 09/04/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MTSProjectTableViewCell.h"
@interface MTSProjectTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *wrapView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end

@implementation MTSProjectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.wrapView.layer.cornerRadius = 8.0;
    self.wrapView.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = 27.5 ;
    self.avatarImageView.layer.masksToBounds = YES;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
