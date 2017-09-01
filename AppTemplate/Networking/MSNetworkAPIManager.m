//
//  MSNetworkAPIManager.m
//  AppTemplate
//
//  Created by Monster on 01/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MSNetworkAPIManager.h"
#import "Common.h"

@implementation MSNetworkAPIManager

//API Base URL Here
#define APIBaseURL @"https://api.unsplash.com/"

static dispatch_once_t onceToken = 0;

+ (instancetype)sharedClient {
    static MSNetworkAPIManager *_sharedClient = nil;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sharedClient = [[MSNetworkAPIManager alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURL ] sessionConfiguration:config];
        
        _sharedClient.responseSerializer = [AFCompoundResponseSerializer serializer];
        _sharedClient.requestSerializer.timeoutInterval = 20;
    });
    
    return _sharedClient;
}

- (void)requestJSONDataWithPath:(NSString *)aPath
                         params:(NSDictionary*)params
                     methodType:(HttpMethod)method
                       callback:(void (^)(id data, NSError *error))block {
    [self requestJSONDataWithPath:aPath userToken:nil params:params methodType:method callback:block];
}

- (void)requestJSONDataWithPath:(NSString *)aPath
                      userToken:(NSString *)token
                         params:(NSDictionary *)params
                     methodType:(HttpMethod)method
                       callback:(void (^)(id data, NSError *error))block {
    if (!aPath || aPath.length <= 0) {
        return;
    }
    if (token) {
        [self.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    }
      [self requestWithPath:aPath params:params methodType:method callback:block];
}


- (NSError *)handleResponse:(id)responseJSON {
    if ([responseJSON isKindOfClass:[NSError class]]) {
        NSError *error = (NSError *)responseJSON;
        return [NSError errorWithDomain:error.domain
                                   code:error.code
                               userInfo:@{@"code" : @(error.code),
                                          @"message" : [error localizedDescription]}];
    }
    if (![responseJSON isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSDictionary *errorInfo = [responseJSON valueForKeyPath:@"error"];
    if (errorInfo) {
        if ([errorInfo isKindOfClass:[NSDictionary class]]) {
            return [NSError errorWithDomain:NSCocoaErrorDomain
                                       code:errorInfo[@"code"] ? [errorInfo[@"code"] integerValue] : NSURLErrorUnknown
                                   userInfo:errorInfo];
        } else if ([errorInfo isKindOfClass:[NSString class]]) {
            return [NSError errorWithDomain:NSCocoaErrorDomain
                                       code:responseJSON[@"code"] ? [responseJSON[@"code"] integerValue] : NSURLErrorUnknown
                                   userInfo:@{@"code" : responseJSON[@"code"], @"message" : errorInfo}];
        }
    }
    // code非200时，表示有错
    NSNumber *resultCode = [responseJSON valueForKeyPath:@"code"];
    if (resultCode && [resultCode isKindOfClass:[NSNumber class]] && resultCode.intValue != 200 && resultCode.intValue != 0) {
        return [NSError errorWithDomain:NSCocoaErrorDomain
                                   code:resultCode.intValue
                               userInfo:responseJSON];
    }
    
    return nil;
}

#pragma mark - Private

- (void)requestWithPath:(NSString *)aPath
                 params:(NSDictionary*)params
             methodType:(HttpMethod)method
               callback:(void (^)(id data, NSError *error))block {
    switch (method) {
        case GET: {
            [self GET:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError *error = nil;
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&error];
                //                DLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                error = [self handleResponse:responseObject];
                if (block) {
                    if (error) {
                        block(nil, error);
                    } else {
                        block(responseObject, nil);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                error = [self handleResponse:error];
                if (block) {
                    block(nil, error);
                }
            }];
            break;
        }
        case POST: {
            [self POST:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError *error = nil;
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&error];
                DLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                error = [self handleResponse:responseObject];
                if (block) {
                    if (error) {
                        block(nil, error);
                    } else {
                        block(responseObject, nil);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                error = [self handleResponse:error];
                if (block) {
                    block(nil, error);
                }
            }];
            break;
        }
        case PUT: {
            [self PUT:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError *error = nil;
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&error];
                DLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                error = [self handleResponse:responseObject];
                if (block) {
                    if (error) {
                        block(nil, error);
                    } else {
                        block(responseObject, nil);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                error = [self handleResponse:error];
                if (block) {
                    block(nil, error);
                }
            }];
            break;
        }
        case DELETE: {
            [self DELETE:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError *error = nil;
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&error];
                DLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                error = [self handleResponse:responseObject];
                if (block) {
                    if (error) {
                        block(nil, error);
                    } else {
                        block(responseObject, nil);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                error = [self handleResponse:error];
                if (block) {
                    block(nil, error);
                }
            }];
            break;
        }
        default:
            break;
    }
}


@end
