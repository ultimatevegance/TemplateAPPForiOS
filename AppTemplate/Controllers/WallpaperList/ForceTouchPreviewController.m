//
//  ForceTouchPreviewController.m
//  AppTemplate
//
//  Created by Monster on 08/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "ForceTouchPreviewController.h"
#import "FCAlertview.h"
#import "MSNetworkAPIManager.h"
#import "SVProgressHUD.h"
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

#pragma mark - Preview Actions

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    
    // setup a list of preview actions
    UIPreviewAction *showCredits = [UIPreviewAction actionWithTitle:@"Show Credits" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [self showInfo];
    }];
    
    UIPreviewAction *download = [UIPreviewAction actionWithTitle:@"Download" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [self download];
    }];
    
    // add them to an arrary
    NSArray *actions = @[showCredits, download];
    return actions;
}

-  (void) showInfo {
    
    FCAlertView *infoAlertView = [[FCAlertView alloc] init];
    infoAlertView.darkTheme = YES;
    infoAlertView.customImageScale = 2;
    infoAlertView.animateAlertInFromTop = YES;
    infoAlertView.animateAlertOutToBottom = YES;
    infoAlertView.bounceAnimations = YES;
    infoAlertView.detachButtons = YES;
    infoAlertView.avoidCustomImageTint = YES;
    infoAlertView.titleFont = [UIFont systemFontOfSize:25 weight:20];
    NSString *userName = _userData.name;
    NSString *stats = [NSString stringWithFormat:@"%ld likes    &   %ld photos",(long)_userData.total_likes.integerValue,(long)_userData.total_photos.integerValue];
    // TODO : show user avatar image
    //    UIImage *userAvatar = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_userData.profile_image]]];
    [infoAlertView showAlertWithTitle:userName withSubtitle:stats withCustomImage:[UIImage imageNamed:@"iconicButton"] withDoneButtonTitle:@"OK" andButtons:nil];
}

- (void)download{
    if (_downloadSourceUrlString) {
        [_downloadSourceUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        NSURL *imageDownloadUrl = [NSURL URLWithString:_downloadSourceUrlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:imageDownloadUrl];
        NSURLSessionDownloadTask *downloadTask = [[MSNetworkAPIManager sharedClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showProgress:downloadProgress.fractionCompleted status:@"Downloading"];
            });
        } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            //            NSLog(@"File downloaded to: %@", filePath);
            UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:filePath]];
            UIImageWriteToSavedPhotosAlbum(downloadedImage,self,@selector(thisImage:hasBeenSavedInPhotoAlbumWithError:usingContextInfo:),NULL);
        }];
        [downloadTask resume];
    }

}

- (void)thisImage:(UIImage *)image hasBeenSavedInPhotoAlbumWithError:(NSError *)error usingContextInfo:(void*)ctxInfo {
    [SVProgressHUD showSuccessWithStatus:@"Saved To Albums"];
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
