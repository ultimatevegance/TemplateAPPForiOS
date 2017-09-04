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
#import "MSNetworkAPIManager.h"
#import "SVProgressHUD.h"

#define APIClientKey @"Client-ID 7b8dd28ed85b026b2dac5c80ab1aba0aeb4c8791beced3e104dec4a0dc65cf93"
//Constants
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//Colors
#define PrimaryColororangish [UIColor colorWithRed:253.0f / 255.0f green:128.0f / 255.0f blue:65.0f / 255.0f alpha:1.0f]
#define PrimaryColorbarbiePink [UIColor colorWithRed:255.0f / 255.0f green:76.0f / 255.0f blue:161.0f / 255.0f alpha:1.0f]

#define PrimaryIconColor [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:CGRectMake(0, 0, 30, 30) andColors:@[PrimaryColororangish,PrimaryColorbarbiePink]]
#define PrimaryBarColor [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:CGRectMake(0, 0,kScreenWidth , 100) andColors:@[PrimaryColororangish,PrimaryColorbarbiePink]]
#define PrimaryFullViewColor [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:CGRectMake(0, 0,kScreenWidth , kScreenHeight) andColors:@[PrimaryColororangish,PrimaryColorbarbiePink]]


#ifdef DEBUG
#define DLog(format, ...)   do {                                                \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "--------------\n");                                        \
} while (0)
#else
#define DLog(...)
#endif


#define weakify(...) \
try {} @finally {} \
metamacro_foreach_cxt(mtl_weakify_,, __weak, __VA_ARGS__)


#endif /* Common_h */
