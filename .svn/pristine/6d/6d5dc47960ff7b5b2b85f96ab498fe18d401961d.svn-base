//
//  UIColor+Extension.h
//  AiPark
//
//  Created by zhht01 on 16/3/31.
//  Copyright © 2016年 智慧停车. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)


#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]


/**
 *  从十六进制字符串获取颜色
 *
 *  @param color : @“#123456”、 @“0X123456”、@“0x123456”、  @“123456”三种格式
 *  @param alpha : 透明度 默认为1
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)hexString;

/**
 *  从RGB字符串获取颜色
 *
 *  注意:不需要除以255
 */
+ (UIColor *)colorWithRGBRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

+ (UIColor *)colorWithRGBRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

/**
 *  将颜色转成 16进制
 *
 *  返回颜色格式 : #123456
 */
+ (NSString *)colorToHexStringWithColor:(UIColor *)color;


/**
 *  将颜色转成 RGB
 *
 *  返回颜色格式 : 192,192,222
 */
+ (NSString *)colorToRGBStringWithColor:(UIColor *)color;


/**
 *  将 16进制颜色 转成 RGB颜色
 *
 *  @param hexString : @“#123456”、 @“0X123456”、@“0x123456” 、 @“123456” 四种格式
 *
 *  返回颜色格式 : RGB:192,192,222
 */
+ (NSString *)colorToRGBStringWithHexString:(NSString *)hexString;


/**
 *  将 RGB颜色 转成 16进制颜色
 *
 *  返回颜色格式 : #123456
 */
+ (NSString *)colorToHexStringWithRGBRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;;





@end
