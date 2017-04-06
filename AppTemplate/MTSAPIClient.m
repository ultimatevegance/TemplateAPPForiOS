//
//  MTSAPIClient.m
//  AppTemplate
//
//  Created by MonsterSucker on 06/04/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MTSAPIClient.h"

@implementation MTSAPIClient

static dispatch_once_t onceToken = 0;
+ (instancetype)sharedClient {
    static MTSAPIClient *_sharedClient = nil;
    dispatch_once(&onceToken, ^{
        DRApiClientSettings *settings = [[DRApiClientSettings alloc] initWithBaseUrl:@"https://api.dribbble.com/v1/"
                                                                   oAuth2RedirectUrl:@"http://monstertechstudio.com"
                                                              oAuth2AuthorizationUrl:@"https://dribbble.com/oauth/authorize"
                                                                      oAuth2TokenUrl:@"https://dribbble.com/oauth/token"
                                                                            clientId:@"b36bf7f85cda2f0790d2d187407534badc353e397086fd5f05b25da6bdd30861"
                                                                        clientSecret:@"e6d87fa920a17570c545e2e7d90b6de20f5dfd63492ccba32ca2e57a6e453e15"
                                                                   clientAccessToken:@"d68bcb10e7a7988183515ea73a27037f019c0bb635e59e6fd27b50866fdc06ed"
                                                                              scopes:[NSSet setWithObjects:@"public", @"write", @"upload", nil]];
        _sharedClient = [[MTSAPIClient alloc] initWithSettings:settings];

    });
    
    return _sharedClient;
}
@end
