//
//  CollectionDetailViewController.h
//  AppTemplate
//
//  Created by Monster on 05/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSUserData.h"
@interface CollectionDetailViewController : UIViewController

- (instancetype)initWithCollectionID:(NSNumber *)collectionID  User:(MSUserData *)user;

@end
