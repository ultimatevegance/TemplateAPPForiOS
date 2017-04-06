//
//  MTSAPIClient.h
//  AppTemplate
//
//  Created by MonsterSucker on 06/04/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import <DribbbleSDK/DribbbleSDK.h>

@interface MTSAPIClient : DRApiClient

+ (instancetype)sharedClient;
@end
