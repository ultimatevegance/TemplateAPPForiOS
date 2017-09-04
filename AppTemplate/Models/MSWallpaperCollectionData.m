//
//  MSWallpaperCollectionData.m
//  AppTemplate
//
//  Created by Monster on 04/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MSWallpaperCollectionData.h"
#import "MSNetworkAPIManager.h"
@implementation MSWallpaperCollectionData

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"Id" : @"id",
             @"title" : @"title",
             @"mDescription" : @"description",
             @"total_photos" : @"total_photos",
             @"coverImageUrl" : @"cover_photo.urls.regular",
             @"published_at" : @"published_at",
             @"user" : @"user",
             @"curated" : @"curated",
             @"featured" : @"featured",
             };
}

+ (void)requestWallpaperCollectionsDataWithAPIKey:(NSString *)APIKey parameter:(NSDictionary *)param callback:(void (^)( NSArray*, NSError *))block {
    
    [[MSNetworkAPIManager sharedClient] requestJSONDataWithPath:@"collections/featured" userToken:APIKey params:param methodType:GET callback:^(id data, NSError *error) {
        if (block) {
            NSArray *wallpaperCollectionDataArray = [MTLJSONAdapter modelsOfClass:[MSWallpaperCollectionData class]
                                                          fromJSONArray:data
                                                                  error:&error];
            block(wallpaperCollectionDataArray, error);
        }
        
        
    }];
}



@end
