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
//Constants
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//Colors
#define PrimaryThemeColor [UIColor colorWithHexString:@"16DAFF" withAlpha:1]
#define PrimaryBackgroundColor [UIColor colorWithHexString:@"121317" withAlpha:1]
//Fonts
#define UINavigationBarFont [UIFont fontWithName:@"HypatiaSansPro-Bold" size:20]
#define UISegmentControlFont [UIFont fontWithName:@"HypatiaSansPro-Bold" size:15]
#define UITabBarFont [UIFont fontWithName:@"HypatiaSansPro-Semibold" size:10]

#import <JLTMDbClient.h>
#import <Mantle.h>
#import "MTSMovieData.h"
#import "UIImageView+YYWebImage.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"

#endif /* Common_h */
