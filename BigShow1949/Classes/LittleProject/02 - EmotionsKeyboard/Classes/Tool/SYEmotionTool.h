//
//  SYEmotionTool.h
//  01 - 表情键盘
//
//  Created by apple on 15-1-30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYEmotionTool : NSObject
/**
 *  默认的表情数据(数组里面装的都是模型, HWEmotion)
 */
+ (NSArray *)defaultEmotions;
/**
 *  最近的表情数据(数组里面装的都是模型, HWEmotion)
 */
+ (NSArray *)recentEmotions;
/**
 *  浪小花的表情数据(数组里面装的都是模型, HWEmotion)
 */
+ (NSArray *)lxhEmotions;
@end
