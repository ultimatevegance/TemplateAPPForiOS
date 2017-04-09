//
//  TableViewCell.m
//  AppTemplate
//
//  Created by MonsterSucker on 20/03/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "TableViewCell.h"
#import "YYWebImage.h"
#import "MBCircularProgressBarView.h"
@interface TableViewCell ()
@property (weak, nonatomic) IBOutlet MBCircularProgressBarView *loadingProgressView;

@property (weak, nonatomic) IBOutlet UIView *wraperView;
@property (weak, nonatomic) IBOutlet UIImageView *_imageView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewCount;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.wraperView.layer.cornerRadius = 6;
    self.wraperView.layer.masksToBounds = YES;
    self.userImageView.layer.cornerRadius = 27.5;
    self.userImageView.layer.masksToBounds = YES;
}
- (void)setShotData:(DRShot *)shotData {
    _shotData = shotData;
    _titleLabel.text = _shotData.user.username;
    _locationLabel.text = _shotData.user.location == nil ? @"Unknown" : _shotData.user.location ;
    _viewCount.text = [NSString stringWithFormat:@"%@",_shotData.viewsCount];
    _commentCountLabel.text = [NSString stringWithFormat:@"%@",_shotData.commentsCount];
    _likeCountLabel.text = [NSString stringWithFormat:@"%@",_shotData.likesCount];
    if (_shotData.isAnimation) {
        [self.imageView yy_setImageWithURL:[NSURL URLWithString:_shotData.images.hidpi] placeholder:[UIImage imageNamed:@"shotPlaceholder"]];
           } else {
        [self.imageView yy_setImageWithURL:[NSURL URLWithString:_shotData.images.normal] placeholder:[UIImage imageNamed:@"shotPlaceholder"]];
    }
        [self.userImageView yy_setImageWithURL:[NSURL URLWithString:_shotData.user.avatarUrl] placeholder:[UIImage imageNamed:@"AvatarDefault"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
