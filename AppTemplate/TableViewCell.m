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
    
}
- (void)setShotData:(DRShot *)shotData {
    _shotData = shotData;
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:_shotData.images.normal] options:YYWebImageOptionProgressiveBlur];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
