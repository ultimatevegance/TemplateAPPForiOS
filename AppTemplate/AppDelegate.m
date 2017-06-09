//
//  AppDelegate.m
//  AppTemplate
//
//  Created by MonsterSucker on 19/03/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "AppDelegate.h"
#import "MSTTabBarCtrl.h"
#import "Common.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (void)setAppearence {
    [[UITabBar appearance ] setTintColor:PrimaryThemeColor];
    [[UITabBar appearance] setTranslucent:YES];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName :UITabBarFont} forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
    [[UINavigationBar appearance] setTintColor:PrimaryThemeColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : PrimaryThemeColor,NSFontAttributeName :UINavigationBarFont}];
    [[UITabBar appearance ] setBarStyle:UIBarStyleBlack];

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.rootViewController = [[MSTTabBarCtrl alloc]  init];
    [self.window makeKeyAndVisible ] ;
    [self setAppearence];
    [[JLTMDbClient sharedAPIInstance] setAPIKey:@"8a35532cc4b71203496a560589eb0358"];
    [self loadImageURLConfig];
    //print out all the font to find out the custom font name
//    for (NSString* family in [UIFont familyNames])
//    {
//        NSLog(@"%@", family);
//        
//        for (NSString* name in [UIFont fontNamesForFamilyName: family])
//        {
//            NSLog(@"  %@", name);
//        }
//    }
    return YES;
}

- (void)loadImageURLConfig {
    [[JLTMDbClient sharedAPIInstance] GET:kJLTMDbConfiguration withParameters:nil andResponseBlock:^(id response, NSError *error) {
        if (!error)
            self.imagesBaseUrlString = [response[@"images"][@"base_url"] stringByAppendingString:@"w300"];
        else {
        
        };
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
