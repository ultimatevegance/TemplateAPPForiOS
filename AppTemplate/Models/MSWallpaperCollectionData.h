//
//  MSWallpaperCollectionData.h
//  AppTemplate
//
//  Created by Monster on 04/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import <Mantle/Mantle.h>
@class MSUserData;
@interface MSWallpaperCollectionData : MTLModel<MTLJSONSerializing>

@property(nonatomic,copy)NSNumber *Id;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *mDescription;
@property(nonatomic,copy)NSNumber *total_photos;
@property(nonatomic,copy)NSString *coverImageUrl;
@property(nonatomic,copy)NSString *published_at;
@property(nonatomic,copy) MSUserData *user;
@property BOOL curated;
@property BOOL featured;

+ (void)requestWallpaperCollectionsDataWithAPIKey:(NSString *)APIKey parameter:(NSDictionary *)param callback:(void (^)( NSArray*, NSError *))block;

@end
