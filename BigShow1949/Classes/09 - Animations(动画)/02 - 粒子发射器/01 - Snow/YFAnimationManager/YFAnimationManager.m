//
//  YFAnimationManager.m
//  YFAnimationStyle
//
//  Created by ykh on 15/5/28.
//  Copyright (c) 2015年 YKH. All rights reserved.
//

#import "YFAnimationManager.h"
#import "YFEmitterCustomLayer.h"

@implementation YFAnimationManager

static id manager;

+(instancetype)shareInstancetype{
    YFAnimationManager *animationManager=[[YFAnimationManager alloc] init];
    return animationManager;
}

-(void)showAnimationInView:(UIView *)superView withAnimationStyle:(YFAnimationStyle)YFAnimationStyle{
    switch (YFAnimationStyle) {
        case YFAnimationStyleOfSnow:
            [YFEmitterCustomLayer addSnowLayerInView:superView];
            break;
        case YFAnimationStyleOfLeaves:
            [YFEmitterCustomLayer addleavesLayerInView:superView];
            break;
        case YFAnimationStyleOfRain:
            [YFEmitterCustomLayer addRainLayerInView:superView];
        default:
            break;
    }
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToke;
    dispatch_once(&onceToke, ^{
        if (manager == nil) {
            manager = [super allocWithZone:zone];
        }
    });
    return manager;
}

@end
