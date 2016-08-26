//
//  XXBRippleView.h
//  waterTest
//
//  Created by Jinhong on 15/2/5.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//  水波纹效果

#import <UIKit/UIKit.h>

@interface XXBRippleView : UIView

/**
 *  最小半径 默认20
 */
@property(nonatomic , assign)CGFloat 	minRadius;
/**
 *  最大半径 默认50
 */
@property(nonatomic , assign)CGFloat 	maxRadius;
/**
 *  园圈的颜色 默认是灰色
 */
@property(nonatomic , strong)UIColor	*rippleColor;
/**
 *  园圈的宽度 默认是1
 */
@property(nonatomic , assign)CGFloat	rippleWidth;
/**
 *  动画时间 默认两秒
 */
@property(nonatomic , assign)CGFloat	animationTime;
/**
 *  开始动画
 */
- (void)startRippleAnimation;
/**
 *  动画一次
 */
- (void)startRippleAnimationOnce;
/**
 *  停止动画
 */
- (void)stopRippleAnimation;
@end
