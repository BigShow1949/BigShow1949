//
//  YFEmitterCustomLayer.h
//  Snowing
//
//  Created by ykh on 15/1/16.
//  Copyright (c) 2015年 YKH. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "YFEmitterSnowCell.h"
@interface YFEmitterCustomLayer : CAEmitterLayer


/**
 *  将默认雪花效果显示到传入的view上
 *
 *  @param view 需要显示雪花效果的view
 */
+ (void)addSnowLayerInView:(UIView *)view;

/**
 *  将默认的飘树叶动画效果显示到传入的view上
 *
 *  @param view 需要显示飘树叶效果的view
 */
+ (void)addleavesLayerInView:(UIView *)view;

/**
 *  将默认的下雨动画效果显示到传入的view上
 *
 *  @param view 需要显示飘树叶效果的view
 */
+ (void)addRainLayerInView:(UIView *)view;




@end
