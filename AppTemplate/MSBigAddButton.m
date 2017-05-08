//
//  MSBigAddButton.m
//  AppTemplate
//
//  Created by Monster on 08/05/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "MSBigAddButton.h"
#import "Common.h"
@implementation MSBigAddButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect {
    self.layer.cornerRadius = CGRectGetHeight(self.frame) / 2;
    self.layer.masksToBounds = NO;
    CALayer *shadowlayer = [CALayer layer];
    shadowlayer.shadowRadius = 14;
    shadowlayer.shadowColor = [UIColor colorWithHexString:@"0F57EC"].CGColor;
    shadowlayer.shadowOffset = CGSizeMake(0, 0);
    shadowlayer.shadowOpacity = 0.7;
    shadowlayer.frame = self.frame;
    shadowlayer.backgroundColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:shadowlayer];
    self.backgroundColor = nil;
    
}


@end
