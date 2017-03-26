//
//  CollectionViewCell.m
//  AppTemplate
//
//  Created by MonsterSucker on 21/03/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "CollectionViewCell.h"
#import "YYWebImage.h"
@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageView.layer.cornerRadius = 6;
    self.imageView.layer.masksToBounds = YES;
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:@"http://img.tuboshu.com/images/article/201409/23/1906/00/201409231906007365_600.gif"] options:YYWebImageOptionProgressiveBlur];


}

@end
