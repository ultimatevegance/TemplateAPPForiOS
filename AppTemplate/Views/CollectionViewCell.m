//
//  CollectionViewCell.m
//  AppTemplate
//
//  Created by MonsterSucker on 21/03/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "CollectionViewCell.h"
#import "YYWebImage.h"
#import "MSWallpaperData.h"

@interface CollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;


@end
@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;

}

- (void)setWallpaperData:(MSWallpaperData *)wallpaperData {
    _wallpaperData = wallpaperData;
    [_coverImageView yy_setImageWithURL:[NSURL URLWithString:_wallpaperData.urls_regular] placeholder:[UIImage imageNamed:@"placeholder"]];

}
@end
