//
//  TableViewCell.m
//  AppTemplate
//
//  Created by MonsterSucker on 20/03/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "TableViewCell.h"
#import "Common.h"
@interface TableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *_imageView;
@property (weak, nonatomic) IBOutlet UIView *priorityView;
@property (weak, nonatomic) IBOutlet UIView *wrapperView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _wrapperView.layer.cornerRadius = 8;
    _wrapperView.layer.masksToBounds = YES;
}


-(void)setData:(DataModel *)data {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}


@end
