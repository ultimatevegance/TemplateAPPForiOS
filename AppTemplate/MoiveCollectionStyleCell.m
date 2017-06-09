//
//  MoiveCollectionStyleCell.m
//  AppTemplate
//
//  Created by MonsterSucker on 09/06/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MoiveCollectionStyleCell.h"
@interface MoiveCollectionStyleCell ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;

@end
@implementation MoiveCollectionStyleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _posterImageView.layer.cornerRadius = 5;
    _posterImageView.layer.masksToBounds = YES;
}

@end
