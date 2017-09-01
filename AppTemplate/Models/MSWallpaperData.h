//
//  MSWallpaperData.h
//  AppTemplate
//
//  Created by Monster on 01/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import <Mantle/Mantle.h>
@class MSUserData;

@interface MSWallpaperData : MTLModel<MTLJSONSerializing>



@property(nonatomic,copy)NSString *Id;
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,strong)NSNumber *width;
@property(nonatomic,strong)NSNumber *height;
@property(nonatomic,copy)NSString *color;
@property(nonatomic,strong)NSNumber *likes;
@property(nonatomic,copy)NSString *wdescription;
@property(nonatomic,strong)MSUserData *user;
@property(nonatomic,copy)NSString *urls_small;
@property(nonatomic,copy)NSString *urls_regular;
@property(nonatomic,copy)NSString *urls_full;
@property(nonatomic,copy)NSString *urls_raw;
@property(nonatomic,copy)NSString *urls_thumb;


+ (void)requestWallpapersDataWithAPIKey:(NSString *)APIKey parameter:(NSDictionary *)param callback:(void (^)( NSArray*, NSError *))block ;


@end
