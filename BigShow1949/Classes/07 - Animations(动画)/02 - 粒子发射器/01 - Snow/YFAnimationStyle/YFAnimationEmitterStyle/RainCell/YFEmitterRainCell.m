//
//  YFEmitterRainCell.m
//  BigShow1949
//
//  Created by 杨帆 on 15-9-4.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

#import "YFEmitterRainCell.h"

@implementation YFEmitterRainCell

+(instancetype)rainCellWithCellImg:(NSString *)cellImg andRadious:(CGFloat)radious andVelocity:(CGFloat)velocity andDirection:(YFEmitterParticleCellDirection)direction
{
    
    NSString * const rainPic = @"rain.png";// 这里没有雨水的默认图片
    
    YFEmitterRainCell *cell=(YFEmitterRainCell *)[[self alloc] init];
    cell.name = @"rain";
    cell.birthRate		= 40.0;
    cell.lifetime		= 120.0;
    
    cell.velocity		= 70;				// falling down slowly
    cell.velocityRange  = 3;
    cell.yAcceleration  = 2;
    cell.emissionRange  = 0.5 * M_PI;		// some variation in angle
    cell.spinRange		= 0.25 * M_PI;		// slow spin
    
    //设置雪花图片
    UIImage *img;
    if (cellImg.length==0) {
        img = [UIImage imageNamed:rainPic];
//        UIColor *color = [UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000];
//        img = [self imageWithColor:color];
    }else{
        img=[UIImage imageNamed:cellImg];
    }
    // 设置雪花半径大小
//    img=[UIImage image:img scaleToSize:CGSizeMake(radious, radious)];
    img=[UIImage image:img scaleToSize:CGSizeMake(1, 50)];
    cell.contents = (id)[img CGImage];
    
    //速率与半径大小正相关
    cell.velocity = radious*2;
    
    //重力加速方向,y代表竖直,x为横向,数值越大,速度越快
    cell.yAcceleration = 4;
    //向周围发散的角度
    cell.emissionRange = 0.5* M_PI;

    
    return cell;
    
}


+ (UIImage*)imageWithColor:(UIColor*)color {
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
