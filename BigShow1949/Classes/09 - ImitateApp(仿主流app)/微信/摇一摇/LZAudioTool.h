//
//  HMAudioTool.h
//
//
//  Created by apple on 14-8-8.
//  Copyright (c) 2014年 帶頭二哥. All rights reserved.
//  播放本地音乐

#import <Foundation/Foundation.h>

@interface LZAudioTool : NSObject
/**
 *  播放音乐
 *
 *  @param filename 音乐的文件名
 */
+ (BOOL)playMusic:(NSString *)filename;
@end
