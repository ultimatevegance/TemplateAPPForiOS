//
//  MTSDesingerCollectionViewCell.m
//  AppTemplate
//
//  Created by MonsterSucker on 09/04/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MTSDesingerCollectionViewCell.h"
#import "Common.h"
@interface MTSDesingerCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *followButton;


@end

@implementation MTSDesingerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 8.0;
    self.layer.masksToBounds = YES;
    self.userAvatarImageView.layer.cornerRadius   = kScreenHeight * 0.0412;
    self.userAvatarImageView.layer.masksToBounds = YES;
    }

@end
