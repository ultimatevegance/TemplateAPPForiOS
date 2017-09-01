//
//  MSWallpaperData.m
//  AppTemplate
//
//  Created by Monster on 01/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MSWallpaperData.h"
#import "MSNetworkAPIManager.h"
@implementation MSWallpaperData
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"Id" : @"id",
             @"created_at" : @"created_at",
             @"width" : @"width",
             @"height" : @"height",
             @"color" : @"color",
             @"likes" : @"likes",
             @"wdescription" : @"description",
             @"user" : @"user",
             @"urls_small" : @"urls.small",
             @"urls_regular" : @"urls.regular",
             @"urls_full" : @"urls.full",
             @"urls_raw" : @"urls.raw",
             @"urls_thumb" : @"urls.thumb",
             };
}

+ (void)requestWallpapersDataWithAPIKey:(NSString *)APIKey parameter:(NSDictionary *)param callback:(void (^)( NSArray*, NSError *))block {
    
    [[MSNetworkAPIManager sharedClient] requestJSONDataWithPath:@"photos" userToken:APIKey params:param methodType:GET callback:^(id data, NSError *error) {
        if (block) {
            NSArray *wallpaperDataArray = [MTLJSONAdapter modelsOfClass:[MSWallpaperData class]
                                                          fromJSONArray:data
                                                                  error:&error];
            block(wallpaperDataArray, error);
        }

        
    }];
}


@end
