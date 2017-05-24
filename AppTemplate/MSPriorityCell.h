//
//  MSPriorityCell.h
//  AppTemplate
//
//  Created by Monster on 17/05/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSPriorityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *indicatorImageView;
@property (weak, nonatomic) IBOutlet UIView *wrapperView;

@end
