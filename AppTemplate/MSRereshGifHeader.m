//
//  MSRereshGifHeader.m
//  DribbbleApp
//
//  Created by Monster on 13/12/2016.
//  Copyright © 2016 MonsterTech Studio. All rights reserved.
//

#import "MSRereshGifHeader.h"

@implementation MSRereshGifHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=40; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"circle_loading%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 41; i<=82; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"circle_loading%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *onRefreshingImages = [NSMutableArray array];
    for (NSUInteger i = 41; i<=82; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"circle_loading%zd", i]];
        [refreshingImages addObject:image];
    }

    [self setImages:onRefreshingImages forState:MJRefreshStateRefreshing];
}

@end
