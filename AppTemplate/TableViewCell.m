//
//  TableViewCell.m
//  AppTemplate
//
//  Created by MonsterSucker on 20/03/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "TableViewCell.h"
#import "YYWebImage.h"
@interface TableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *_imageView;

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageView.layer.cornerRadius = 6;
    self.imageView.layer.masksToBounds = YES;
//    [self.imageView yy_setImageWithURL:[NSURL URLWithString:@"http://img.tuboshu.com/images/article/201409/23/1906/00/201409231906007365_600.gif"] options:YYWebImageOptionProgressiveBlur];
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:@"https://d13yacurqjgara.cloudfront.net/users/418188/screenshots/3383625/home_budget_app_interaction_animation_tubik.gif"] options:YYWebImageOptionProgressiveBlur];

    
}

-(void)setData:(DataModel *)data {
    _data = data;
    [self.imageView setImage:_data.albumImage];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
