//
//  MTSMovieData.m
//  AppTemplate
//
//  Created by MonsterSucker on 09/06/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MTSMovieData.h"

@implementation MTSMovieData

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"vote_count" : @"vote_count",
             @"movieId" : @"id",
             @"video" : @"video",
             @"vote_average" : @"vote_average",
             @"title" : @"title",
             @"popularity" : @"popularity",
             @"poster_path" : @"poster_path",
             @"original_language" : @"original_language",
             @"original_title" : @"original_title",
             @"genre_ids" : @"genre_ids",
             @"backdrop_path" : @"backdrop_path",
             @"overview" : @"overview",
             @"release_date" : @"release_date",
             };
}

+ (NSValueTransformer *)videoJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)adultJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}


@end
