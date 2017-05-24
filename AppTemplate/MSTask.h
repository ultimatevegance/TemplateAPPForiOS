//
//  MSTask.h
//  AppTemplate
//
//  Created by Monster on 16/05/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import <Mantle/Mantle.h>

typedef enum {
    
    MSTaskPriorityLow,
    MSTaskPriorityNormal,
    MSTaskPriorityHigh,
    
}MSTaskPriority;

@interface MSTask : MTLModel<MTLJSONSerializing>

@property(copy,nonatomic)NSString *taskTitle;
@property(copy,nonatomic)NSString *taskDescription;
@property(strong,nonatomic)NSDate *dueDate;
@property(assign,nonatomic)MSTaskPriority priority;

@end
