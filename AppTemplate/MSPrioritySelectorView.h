//
//  MSPrioritySelectorView.h
//  AppTemplate
//
//  Created by Monster on 17/05/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSPrioritySelectorView : UIView <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSIndexPath *selectedIndexPath;
@end
