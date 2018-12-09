//
//  UIColor+Extension.m
//  AiPark
//
//  Created by zhht01 on 16/3/31.
//  Copyright © 2016年 智慧停车. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

#pragma mark - 生成颜色
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    NSArray *array = [self rgbArrayWithHexString:hexString];
    
    return [self colorWithRGBRed:[array[0] floatValue] green:[array[1] floatValue] blue:[array[2] floatValue] alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    return [self colorWithHexString:hexString alpha:1.0f];
}

+ (UIColor *)colorWithRGBRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((CGFloat)red / 255.0f) green:((CGFloat)green / 255.0f) blue:((float)blue / 255.0f) alpha:alpha];
}

+ (UIColor *)colorWithRGBRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {

    return [self colorWithRGBRed:red green:green blue:blue alpha:1];
}

#pragma mark - 颜色/字符串 转换
+ (NSString *)colorToHexStringWithColor:(UIColor *)color
{
    const CGFloat *cs=CGColorGetComponents(color.CGColor);
    
    NSString *r = [self  toHex:cs[0]*255];
    NSString *g = [self  toHex:cs[1]*255];
    NSString *b = [self  toHex:cs[2]*255];
    return [NSString stringWithFormat:@"#%@%@%@",r,g,b];
}

+ (NSString *)colorToRGBStringWithColor:(UIColor *)color {  // 首先转成rgb

    const CGFloat *cs=CGColorGetComponents(color.CGColor);
    
    int r = cs[0]*255;
    int g = cs[1]*255;
    int b = cs[2]*255;

    return [NSString stringWithFormat:@"RGB:%d,%d,%d",r,g,b];
}

+ (NSString *)colorToRGBStringWithHexString:(NSString *)hexString {
    
    NSArray *array = [self rgbArrayWithHexString:hexString];
    
    return [NSString stringWithFormat:@"RGB:%d,%d,%d", [array[0] integerValue], [array[1] integerValue], [array[2] integerValue]];
}

+ (NSString *)colorToHexStringWithRGBRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {

    NSString *rStr = [self toHex:red];
    NSString *gStr = [self toHex:green];
    NSString *bStr = [self toHex:blue];

    return [NSString stringWithFormat:@"#%@%@%@", rStr, gStr, bStr];
}


#pragma mark - private method
// 将 16进制字符串 转成 10进制字符串 注意:只能两位
+ (NSString *)toRGB:(NSString *)tmpid{  // 等会判断
    
    // 第一位
    NSString *firstStr = [tmpid substringToIndex:1];
    int first;
    if ([firstStr isEqualToString:@"A"]) {
        first = 10;
    }else if ([firstStr isEqualToString:@"B"]) {
        first = 11;
    }else if ([firstStr isEqualToString:@"C"]) {
        first = 12;
    }else if ([firstStr isEqualToString:@"D"]) {
        first = 13;
    }else if ([firstStr isEqualToString:@"E"]) {
        first = 14;
    }else if ([firstStr isEqualToString:@"F"]) {
        first = 15;
    }else {
        first = firstStr.intValue;
    }
    
    // 第二位
    NSString *secondStr = [tmpid substringFromIndex:1];
    int second;
    if ([secondStr isEqualToString:@"A"]) {
        second = 10;
    }else if ([secondStr isEqualToString:@"B"]) {
        second = 11;
    }else if ([secondStr isEqualToString:@"C"]) {
        second = 12;
    }else if ([secondStr isEqualToString:@"D"]) {
        second = 13;
    }else if ([secondStr isEqualToString:@"E"]) {
        second = 14;
    }else if ([secondStr isEqualToString:@"F"]) {
        second = 15;
    }else {
        second = secondStr.intValue;
    }
   
//    NSLog(@"first = %d, second = %d", first, second);
    int result = first * 16 + second;
    return [NSString stringWithFormat:@"%d", result];
}


// 将int型的十进制转成 16进制 (默认都转成16进制的)  注意:前面没有补0
+ (NSString *)toHex:(int)tmpid
{
    NSString *endtmp=@"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig=tmpid%16;
    int tmp=tmpid/16;
    switch (ttmpig)
    {
        case 10:
            nLetterValue =@"A";break;
        case 11:
            nLetterValue =@"B";break;
        case 12:
            nLetterValue =@"C";break;
        case 13:
            nLetterValue =@"D";break;
        case 14:
            nLetterValue =@"E";break;
        case 15:
            nLetterValue =@"F";break;
        default:nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
            
    }
    switch (tmp)
    {
        case 10:
            nStrat =@"A";break;
        case 11:
            nStrat =@"B";break;
        case 12:
            nStrat =@"C";break;
        case 13:
            nStrat =@"D";break;
        case 14:
            nStrat =@"E";break;
        case 15:
            nStrat =@"F";break;
        default:nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
            
    }
    endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    return endtmp;
}

+ (NSString *)filterHexString:(NSString *)hexString { // 如果hexString不合要求, 则返回nil

    if ([hexString length] < 6)
    {
        return nil;
    }
    // strip 0X if it appears
    //如果是0X开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([hexString hasPrefix:@"0X"])
    {
        hexString = [hexString substringFromIndex:2];
    }
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([hexString hasPrefix:@"0x"])
    {
        hexString = [hexString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([hexString hasPrefix:@"#"])
    {
        hexString = [hexString substringFromIndex:1];
    }
    if ([hexString length] != 6)
    {
        return nil;
    }
    
    return hexString;
}



/**
 *  将16进制字符串转成数组(三个元素), 分别对应RGB, 且为字符串类型
 *
 *  @param hexString : @“#123456”、 @“0X123456”、@“0x123456”、  @“123456”三种格式
 *
 */
+ (NSArray<NSString *> *)rgbArrayWithHexString:(NSString *)hexString {

    //删除字符串中的空格
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    cString = [self filterHexString:cString];
    
    if (!cString) {  // cString 格式不合要求
        return nil;
    }
    
    // 16进制字符串
    NSRange range;
    range.location = 0;
    range.length = 2;
    // r  @"DF" --> @"223"
    NSString *rString = [self toRGB:[cString substringWithRange:range]];
    //g
    range.location = 2;
    NSString *gString = [self toRGB:[cString substringWithRange:range]];
    //b
    range.location = 4;
    NSString *bString = [self toRGB:[cString substringWithRange:range]];
    
    //
//    // Scan values  // 没用到这个 @"DF" --> 223
//    unsigned int r, g, b;
//    [[NSScanner scannerWithString:rString] scanHexInt:&r];
//    [[NSScanner scannerWithString:gString] scanHexInt:&g];
//    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    NSArray *array = @[rString, gString, bString];

    return array;
}


/**
 *  测试方法: 打印color的元素
 *
 */
- (void)componentsWithColor:(UIColor *)color {

    NSUInteger num = CGColorGetNumberOfComponents(color.CGColor);
    const CGFloat *colorComponents = CGColorGetComponents(color.CGColor);
    for (int i = 0; i < num; ++i) {
        NSLog(@"color components %d: %f", i, colorComponents[i]);
    }
}

@end
