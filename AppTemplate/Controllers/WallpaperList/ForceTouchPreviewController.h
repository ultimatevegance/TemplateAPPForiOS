//
//  ForceTouchPreviewController.h
//  AppTemplate
//
//  Created by Monster on 08/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSUserData.h"
@interface ForceTouchPreviewController : UIViewController

- (instancetype)initWithSourceImage: (UIImage *)wallpaper DownloadUrl:(NSString *)downloadUrl User:(MSUserData *)user;

@end
