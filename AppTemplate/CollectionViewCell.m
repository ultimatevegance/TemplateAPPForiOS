//
//  CollectionViewCell.m
//  AppTemplate
//
//  Created by MonsterSucker on 21/03/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "CollectionViewCell.h"
#import "YYWebImage.h"

@interface CollectionViewCell()
@property (weak, nonatomic) IBOutlet UIView *iconView;

@end
@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 7;
    self.layer.masksToBounds = YES;
    _iconView.layer.cornerRadius = CGRectGetWidth(_iconView.frame) / 2;
    _iconView.layer.masksToBounds = YES;

}

@end
