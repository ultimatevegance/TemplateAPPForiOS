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
    [[UITabBar appearance] setTranslucent:NO];
    //remove bar border line
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setTranslucent:YES];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    [[UINavigationBar appearance] setTintColor:PrimaryThemeColor];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : PrimaryBarTitleColor,NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-DemiBold" size:20.0] }];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance ] setBarStyle:UIBarStyleDefault];
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.rootViewController = [[MSTTabBarCtrl alloc]  init];
    [self.window makeKeyAndVisible ] ;
//    [Chameleon setGlobalThemeUsingPrimaryColor:PrimaryBarColor withSecondaryColor:PrimaryColorbarbiePink usingFontName:@"AppleGothic" andContentStyle:UIContentStyleContrast];
    [self setAppearence];

    
    return YES;
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
