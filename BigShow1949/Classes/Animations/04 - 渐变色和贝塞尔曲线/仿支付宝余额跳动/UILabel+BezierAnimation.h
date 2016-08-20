//
//  UILabel+BezierAnimation.h
//  Test
//
//  Created by senro wang on 15/8/11.
//  Copyright (c) 2015年 王燊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (BezierAnimation)

//label 上的数字  从某一个值变化到 另一个值  －  （动画） － 

- (void)animationFromnum:(float )fromNum toNum:(float )toNum duration:(float )duration;


@end
