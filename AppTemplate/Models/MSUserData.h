//
//  MSUserData.h
//  AppTemplate
//
//  Created by Monster on 01/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MSUserData : MTLModel<MTLJSONSerializing>

@property(nonatomic,copy)NSString *Id;
@property(nonatomic,copy)NSString *updated_at;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *portfolio_url;
@property(nonatomic,strong)NSNumber *total_likes;
@property(nonatomic,strong)NSNumber *total_photos;
@property(nonatomic,strong)NSNumber *total_collections;
@property(nonatomic,copy)NSString *profile_image;
@end
