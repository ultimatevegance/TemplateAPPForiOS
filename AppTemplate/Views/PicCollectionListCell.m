//
//  PicCollectionListCell.m
//  AppTemplate
//
//  Created by MonsterSucker on 01/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "PicCollectionListCell.h"
@interface PicCollectionListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@end
@implementation PicCollectionListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = 20;
    _avatarImageView.layer.masksToBounds = YES;
}

@end
