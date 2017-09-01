//
//  MSNetworkAPIManager.h
//  AppTemplate
//
//  Created by Monster on 01/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


typedef NS_ENUM(NSUInteger, HttpMethod) {
    GET,
    POST,
    PUT,
    DELETE
};

@interface MSNetworkAPIManager : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (void)requestJSONDataWithPath:(NSString *)aPath
                         params:(NSDictionary*)params
                     methodType:(HttpMethod)method
                       callback:(void (^)(id data, NSError *error))block;

- (void)requestJSONDataWithPath:(NSString *)aPath
                      userToken:(NSString *)token
                         params:(NSDictionary *)params
                     methodType:(HttpMethod)method
                       callback:(void (^)(id data, NSError *error))block;

@end
