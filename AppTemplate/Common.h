//
//  Common.h
//  AppTemplate
//
//  Created by MonsterSucker on 20/03/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#ifndef Common_h
#define Common_h

#import <Chameleon.h>
#import "Canvas.h"
#import "UIView+DCAnimationKit.h"
#import <QuartzCore/QuartzCore.h>
#import "HSDatePickerViewController.h"
#import "QMUIKit.h"

//Constants
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//Colors
#define PrimaryColororangish [UIColor colorWithRed:253.0f / 255.0f green:128.0f / 255.0f blue:65.0f / 255.0f alpha:1.0f]
#define PrimaryColorbarbiePink [UIColor colorWithRed:255.0f / 255.0f green:76.0f / 255.0f blue:161.0f / 255.0f alpha:1.0f]

#define GradientThemeColor [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andColors:@[ [UIColor colorWithHexString:@"43E695"],[UIColor colorWithHexString:@"3BB2B8"]]]


#define PrimaryThemeColor [UIColor colorWithHexString:@"0F57EC"]
#define PrimaryBarTitleColor [UIColor colorWithHexString:@"787779"]
#define PrimaryBackgroundColor [UIColor colorWithHexString:@"E9E9EB"]
#define PrimaryIconColor [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:CGRectMake(0, 0, 30, 30) andColors:@[PrimaryColororangish,PrimaryColorbarbiePink]]
#define PrimaryBarColor [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:CGRectMake(0, 0,kScreenWidth , 100) andColors:@[PrimaryColororangish,PrimaryColorbarbiePink]]
#define PrimaryFullViewColor [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:CGRectMake(0, 0,kScreenWidth , kScreenHeight) andColors:@[PrimaryColororangish,PrimaryColorbarbiePink]]


//Notifications
#define kPrioritySelectedNotification  @"PrioritySelectedNotification"
#endif /* Common_h */
