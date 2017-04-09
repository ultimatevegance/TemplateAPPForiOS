//
//  MTSBannerView.m
//  AppTemplate
//
//  Created by MonsterSucker on 09/04/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MTSBannerView.h"
#import "YYAnimatedImageView.h"
@interface MTSBannerView ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet YYAnimatedImageView *backImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
@implementation MTSBannerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.avatarImageView.layer.cornerRadius = 25 ;
    self.avatarImageView.layer.masksToBounds = YES;
    
    
}


@end
