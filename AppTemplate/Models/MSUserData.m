//
//  MSUserData.m
//  AppTemplate
//
//  Created by Monster on 01/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MSUserData.h"

@implementation MSUserData

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"Id" : @"id",
             @"updated_at" : @"updated_at",
             @"name" : @"name",
             @"portfolio_url" : @"portfolio_url",
             @"total_likes" : @"total_likes",
             @"total_photos" : @"total_photos",
             @"total_collections" : @"total_collections",
             @"profile_image" : @"profile_image.medium",
             };
}

@end
