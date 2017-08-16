//
//  BMWaveButton.h
//  Circle Button Demo
//  水波纹效果
//  Created by skyming on 14-6-25.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(u_int8_t, BMWaveButtonType) {
    BMWaveButtonDefault = 0x00,
    BMWaveButtonWave = 0x02,
};


@interface BMWaveButton : UIButton

@property (strong, nonatomic) UIColor *borderColor; // 边框默认为白色
@property (nonatomic) CGFloat borderSize; // 默认边框大小 3.0
@property (strong, nonatomic) UIColor *waveColor; // 波纹颜色默认白色

@property (nonatomic) NSInteger timeInterval; // 间隔默认 45 、35
@property (nonatomic) CGFloat waveDuration; // 默认 4.0

@property (nonatomic) BOOL displayShading; //是否支持显示阴影
@property (nonatomic) BMWaveButtonType myButtonType; // 类型


// DefaultType BMWaveButtonDefault
/**
 *  初始化
 *  默认的类型 BMWaveButtonDefault，Frame默认为屏幕中间，建议自定义Frame
 */
- (instancetype)initWithType:(BMWaveButtonType)myType;

/**
 *  初始化
 *  默认的类型 BMWaveButtonDefault，Image 的tinColor为白色，Frame默认为屏幕中间，建议自定义Frame
 *
 */
- (instancetype)initWithType:(BMWaveButtonType)myType  Image:(NSString *)image;

/**
 *  开始波纹
 */
- (void)StartWave;
/**
 *  停止波纹
 */
- (void)StopWave;
@end
