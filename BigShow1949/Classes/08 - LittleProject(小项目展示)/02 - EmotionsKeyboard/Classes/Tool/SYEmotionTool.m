//
//  SYEmotionTool.m
//  01 - 表情键盘
//
//  Created by apple on 15-1-30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SYEmotionTool.h"
#import "SYEmotion.h"
#import "MJExtension.h"

@implementation SYEmotionTool
static NSArray *_defaultEmotions;
static NSArray *_recentEmotions;
static NSArray *_lxhEmotions;

/**
 *  默认的表情数据
 */
+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        // 方法1:
        /*
         NSString *file = [[NSBundle mainBundle] pathForResource:@"default/info.plist" ofType:nil];
         NSArray *dictArray = [NSArray arrayWithContentsOfFile:file];
         _defaultEmotions = [SYEmotion objectArrayWithKeyValuesArray:dictArray];
         */
        
        // 方法2:
        /*
         NSString *file = [[NSBundle mainBundle] pathForResource:@"default/info.plist" ofType:nil];
         _defaultEmotions = [SYEmotion objectArrayWithFile:file];
         */
        
        // 注意:仅仅限于mainBundle中的文件
        _defaultEmotions = [SYEmotion objectArrayWithFilename:@"default/info.plist"];
        
        // 让数组_defaultEmotions里的所有模型对象, 都调用setFolder:这个方法,并把"default"这个值传给他
        // 相当于emotion.folder = @"default";
        //        SYLog(@"%@----", _defaultEmotions);
        
        [_defaultEmotions makeObjectsPerformSelector:@selector(setFolder:) withObject:@"default"];
        
    }
    return _defaultEmotions;
}

/**
 *  最近的表情数据
 */
+ (NSArray *)recentEmotions
{
    return nil;
}

/**
 *  浪小花的表情数据
 */
+ (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        _lxhEmotions = [SYEmotion objectArrayWithFilename:@"lxh/info.plist"];
        [_lxhEmotions makeObjectsPerformSelector:@selector(setFolder:) withObject:@"lxh"];
    }
    return _lxhEmotions;
}

@end

