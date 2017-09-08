//
//  ForceTouchPreviewController.m
//  AppTemplate
//
//  Created by Monster on 08/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "ForceTouchPreviewController.h"

@interface ForceTouchPreviewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *wallpaperImage;
@property (strong, nonatomic) MSUserData *userData;
@property (copy, nonatomic) NSString *downloadSourceUrlString;

@end

@implementation ForceTouchPreviewController

- (instancetype)initWithSourceImage:(UIImage *)wallpaper DownloadUrl:(NSString *)downloadUrl User:(MSUserData *)user {
    self = [super init];
    if (self) {
        _wallpaperImage = wallpaper;
        _userData = user;
        _downloadSourceUrlString = downloadUrl;
        
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_imageView setImage:_wallpaperImage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
