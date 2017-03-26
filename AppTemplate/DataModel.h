//
//  DataModel.h
//  AppTemplate
//
//  Created by MonsterSucker on 20/03/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <UIKit/UIKit.h>
@interface DataModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong) UIImage *albumImage;

@end
