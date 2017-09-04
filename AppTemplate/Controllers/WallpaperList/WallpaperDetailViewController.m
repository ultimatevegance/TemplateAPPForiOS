//
//  WallpaperDetailViewController.m
//  AppTemplate
//
//  Created by Monster on 04/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "WallpaperDetailViewController.h"
#import "CollectionViewCell.h"
#import "YYWebImage.h"
#import "Common.h"
@interface WallpaperDetailViewController ()<UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UIButton *previewButton;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) IBOutlet UIVisualEffectView *toolBarView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) UIImage *wallpaperImage;
@property (strong, nonatomic) MSUserData *userData;
@property (copy, nonatomic) NSString *downloadSourceUrlString;


@end

@implementation WallpaperDetailViewController

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
    [_imageView setImage:_wallpaperImage];
    _toolBarView.layer.cornerRadius = 8.f;
    _toolBarView.layer.masksToBounds = YES;
    ;
    
}

#pragma mark - Helpers

- (void)thisImage:(UIImage *)image hasBeenSavedInPhotoAlbumWithError:(NSError *)error usingContextInfo:(void*)ctxInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"An Error Ocurred!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"Saved To Albums"
         ];    }
}

#pragma mark - Actions

- (IBAction)cancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)preview:(UIButton *)sender {
}

- (IBAction)save:(UIButton *)sender {
    
    if (_downloadSourceUrlString) {
//        [_downloadSourceUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [_downloadSourceUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        NSURL *imageDownloadUrl = [NSURL URLWithString:_downloadSourceUrlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:imageDownloadUrl];
        NSURLSessionDownloadTask *downloadTask = [[MSNetworkAPIManager sharedClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //Update the progress view
                [SVProgressHUD showProgress:downloadProgress.fractionCompleted status:@"Downloading"];
            });
        } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            
            NSLog(@"File downloaded to: %@", filePath);
            UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:filePath]];
            
            UIImageWriteToSavedPhotosAlbum(downloadedImage,
                                           self, // send the message to 'self' when calling the callback
                                           @selector(thisImage:hasBeenSavedInPhotoAlbumWithError:usingContextInfo:), // the selector to tell the method to call on completion
                                           NULL); // you generally won't need a contextInfo here

        }];
        [downloadTask resume];
    }

   }

- (IBAction)showInfo:(UIButton *)sender {
    
}

#pragma mark - RMPZoomTransitionAnimating
- (nonnull UIImageView *)transitionSourceImageView {
    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.coverImageView.image];
    imageView.contentMode = cell.coverImageView.contentMode;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    imageView.frame = [cell.coverImageView convertRect:cell.coverImageView.frame toView:self.collectionView.superview];
    return imageView;
    
}

- (nonnull UIColor *)transitionSourceBackgroundColor {
    return self.collectionView.backgroundColor;;
}

- (CGRect)transitionDestinationImageViewFrame {
    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
    CGRect cellFrameInSuperview = [cell.coverImageView convertRect:cell.coverImageView.frame toView:self.collectionView.superview];
    return cellFrameInSuperview;
    
}

#pragma mark - <UIViewControllerTransitioningDelegate>

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> sourceTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)source;
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> destinationTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)presented;
    if ([sourceTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)] &&
        [destinationTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)]) {
        RMPZoomTransitionAnimator *animator = [[RMPZoomTransitionAnimator alloc] init];
        animator.goingForward = YES;
        animator.sourceTransition = sourceTransition;
        animator.destinationTransition = destinationTransition;
        return animator;
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> sourceTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)dismissed;
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> destinationTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)self;
    if ([sourceTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)] &&
        [destinationTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)]) {
        RMPZoomTransitionAnimator *animator = [[RMPZoomTransitionAnimator alloc] init];
        animator.goingForward = NO;
        animator.sourceTransition = sourceTransition;
        animator.destinationTransition = destinationTransition;
        return animator;
    }
    return nil;
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
