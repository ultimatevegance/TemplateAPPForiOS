//
//  TableViewCell.h
//  AppTemplate
//
//  Created by MonsterSucker on 20/03/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import "MGSwipeTableCell.h"

@interface TableViewCell : MGSwipeTableCell
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property(nonatomic,strong) DataModel *data;
@end
