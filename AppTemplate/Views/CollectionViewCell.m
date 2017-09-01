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
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;

}

@end
