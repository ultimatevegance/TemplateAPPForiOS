//
//  SettingsTableViewController.m
//  AppTemplate
//
//  Created by Monster on 04/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "FCAlertView.h"
#import "Common.h"

@interface SettingsTableViewController ()<UITableViewDelegate>

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)];
    self.title = @"Settings";
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {// rate star
            [self showRater];
           }
        if (indexPath.row == 1) { // feedback
            [self sendFeedback];
        }
    }
}

# pragma mark - Helpers

- (void)showRater {
    FCAlertView *alert = [[FCAlertView alloc] init];
    FCAlertView *alert2 = [[FCAlertView alloc] init];
    [alert2 addButton:@"Yes" withActionBlock:^{
        // open app store;
        NSString *appLink = @"itms://itunes.apple.com/us/app/wallpaperguru/id1279668095?ls=1&mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appLink] options:@{} completionHandler:^(BOOL success) {
            
        }];
    }];
    alert2.doneBlock = ^{
        [SVProgressHUD showImage:[UIImage imageNamed:@"thanks"] status:@"Thank You! O(∩_∩)O"];
    } ;
    alert.bounceAnimations = YES;
    [alert makeAlertTypeRateStars:^(NSInteger rating) {
        if (rating >= 1) {
            [alert2 showAlertWithTitle:@"Rate On App Store?" withSubtitle:nil withCustomImage:nil withDoneButtonTitle:@"Cacel" andButtons:nil];
        }
    }];
    [alert showAlertWithTitle:@"Rate Stars" withSubtitle:@"How do you recommend Wallpaper Guru？" withCustomImage:nil withDoneButtonTitle:@"OK" andButtons:nil];

}

- (void)sendFeedback {
    NSString *strName = [[UIDevice currentDevice] name];
    NSLog(@"%@", strName);//e.g. "My iPhone"
    
    NSString *strSysName = [[UIDevice currentDevice] systemName];
    NSLog(@"%@", strSysName);// e.g. @"iOS"
    
    NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"%@", strSysVersion);// e.g. @"4.0"
    
    NSString *strModel = [[UIDevice currentDevice] model];
    NSLog(@"%@", strModel);// e.g. @"iPhone", @"iPod touch"
    
    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    NSString * appBuildString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    NSString *feedbackUrl = [NSString stringWithFormat: @"mailto:monsterdev@monstertechstudio.com?subject=Feedback&body= Device info : %@ %@ %@ %@ ; App info : version %@ build %@ ",strName,strSysName,strSysVersion,strModel,appVersionString,appBuildString];
    NSString *url = [feedbackUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    [[UIApplication sharedApplication]  openURL: [NSURL URLWithString: url]];

}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dis forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
