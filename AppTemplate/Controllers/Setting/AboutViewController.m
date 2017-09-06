//
//  AboutViewController.m
//  AppTemplate
//
//  Created by Monster on 06/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Load the html as a string from the file system
    NSString *path = [[NSBundle mainBundle] pathForResource:@"About" ofType:@"html"];
    NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    // Tell the web view to load it
    [_webview loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
    
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
