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
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation MoiveCollectionStyleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _posterImageView.layer.cornerRadius = 5;
    _posterImageView.layer.masksToBounds = YES;
}

-(void)setMovieData:(MTSMovieData *)movieData {
    _movieData = movieData;
    _titleLabel.text = _movieData.title;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (_movieData.poster_path) {
        NSString *imageUrl = [delegate.imagesBaseUrlString stringByAppendingString:_movieData.poster_path];
        [_posterImageView yy_setImageWithURL:[NSURL URLWithString:imageUrl] placeholder:[UIImage imageNamed:@"DEFAULT_IMAGE"]];
       }
}
@end
