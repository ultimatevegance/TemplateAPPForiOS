//
//  MTSMovieData.h
//  AppTemplate
//
//  Created by MonsterSucker on 09/06/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//



/**
"vote_count": 902,
"id": 166426,
"video": false,
"vote_average": 6.5,
"title": "Pirates of the Caribbean: Dead Men Tell No Tales",
"popularity": 177.972203,
"poster_path": "/xbpSDU3p7YUGlu9Mr6Egg2Vweto.jpg",
"original_language": "en",
"original_title": "Pirates of the Caribbean: Dead Men Tell No Tales",
"genre_ids": [
              28,
              12,
              35,
              14
              ],
"backdrop_path": "/3DVKG54lqYbdh8RNylXeCf4MBPw.jpg",
"adult": false,
"overview": "Captain Jack Sparrow searches for the trident of Poseidon while being pursued by an undead sea captain and his crew.",
"release_date": "2017-05-23"
**/



#import <Mantle/Mantle.h>

@interface MTSMovieData : MTLModel<MTLJSONSerializing>

@property(copy, nonatomic)NSNumber *vote_count;
@property(copy, nonatomic)NSNumber *movieId;
@property(assign, nonatomic)BOOL video;
@property(strong, nonatomic)NSNumber *vote_average;
@property(copy, nonatomic)NSString *title;
@property(copy, nonatomic)NSNumber *popularity;
@property(copy, nonatomic)NSString *poster_path;
@property(copy, nonatomic)NSString *original_language;
@property(strong, nonatomic)NSString *original_title;
@property(copy, nonatomic)NSArray *genre_ids;
@property(copy, nonatomic)NSString *backdrop_path;
@property(assign, nonatomic)BOOL adult;
@property(copy, nonatomic)NSString *overview;
@property(copy, nonatomic)NSString *release_date;



@end
