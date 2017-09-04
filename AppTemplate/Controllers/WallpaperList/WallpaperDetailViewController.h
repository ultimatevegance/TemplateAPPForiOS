//
//  WallpaperDetailViewController.h
//  AppTemplate
//
//  Created by Monster on 04/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "WallpaperListViewController.h"
#import "RMPZoomTransitionAnimator.h"
#import "MSUserData.h"
@interface WallpaperDetailViewController : WallpaperListViewController<RMPZoomTransitionAnimating>

- (instancetype)initWithSourceImage: (UIImage *)wallpaper DownloadUrl:(NSString *)downloadUrl User:(MSUserData *)user;

@end
