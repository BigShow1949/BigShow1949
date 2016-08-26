//
//  YFAnimationManager.h
//  YFAnimationStyle
//
//  Created by ykh on 15/5/28.
//  Copyright (c) 2015年 YKH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//动画形式
typedef enum{
    YFAnimationStyleOfSnow,     // 雪花
    YFAnimationStyleOfLeaves,   // 树叶
    YFAnimationStyleOfRain,     // 雨水
} YFAnimationStyle;

@interface YFAnimationManager : NSObject


+(instancetype)shareInstancetype;

/**
 *  在一个view上展示传入的动画类型style
 *
 *  @param superView        需要展示传入的动画的View
 *  @param YFAnimationStyle 传入的动画类型
 */
-(void)showAnimationInView:(UIView *)superView withAnimationStyle:(YFAnimationStyle)YFAnimationStyle;

@end
