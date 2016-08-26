//
//  YFEmitterCustomLayer.m
//  Snowing
//
//  Created by ykh on 15/1/16.
//  Copyright (c) 2015年 YKH. All rights reserved.
//

#import "YFEmitterCustomLayer.h"
#import "UIImage+Extension.h"

#import "YFEmitterLeavesCell.h"
#import "YFEmitterSnowCell.h"
#import "YFEmitterRainCell.h"

@implementation YFEmitterCustomLayer

#pragma mark 粒子发射器

//下面这个方法公用,发射器的参数由外部传入
+ (instancetype)addCustomLayerInView:(UIView *)view atPosition:(CGPoint)position inSize:(CGSize)size
{
    YFEmitterCustomLayer *leavesEmitter = (YFEmitterCustomLayer*)[CAEmitterLayer layer];
    
    //例子发射器位置，可以动态设置
    leavesEmitter.emitterPosition = position;
    leavesEmitter.emitterSize = CGSizeMake(size.width, size.height);
    
    //超出图层的雪花全部裁掉
    view.layer.masksToBounds=YES;
    
    //发射模式
    leavesEmitter.emitterMode = kCAEmitterLayerSurface;
    
    //粒子边缘的颜色,设置白色会有模糊效果
    leavesEmitter.shadowColor = [[UIColor whiteColor] CGColor];
    
    //添加图层到显示雪花的view的layer
    [view.layer addSublayer:leavesEmitter];
    
    return leavesEmitter;
}

#pragma mark 树叶

+ (void)leavesLayerInView:(UIView *)view atPosition:(CGPoint)position andDirection:(YFEmitterParticleCellDirection)direction andRadious:(CGFloat)radious andCellImg:(NSString *)cellImg
{
    //创建树叶所在图层layer
    YFEmitterCustomLayer *leavesLayer = [self addCustomLayerInView:view atPosition:position inSize:CGSizeMake(view.frame.size.width, view.frame.size.height)];

    //粒子
    YFEmitterLeavesCell *emitterCell = [YFEmitterLeavesCell leavesCellWithCellImg:cellImg andRadious:radious andVelocity:20 andDirection:direction];
    
    leavesLayer.emitterCells = @[emitterCell];
}

+ (void)addleavesLayerInView:(UIView *)view
{
    //树叶粒子所在view,发射树叶的位置,树叶飘向的方向,树叶粒子半径,树叶粒子图片
    [YFEmitterCustomLayer leavesLayerInView:view atPosition:CGPointMake(-60,-20) andDirection:YFEmitterParticleCellDirectionToBottom andRadious:19 andCellImg:nil];
    
    [YFEmitterCustomLayer leavesLayerInView:view atPosition:CGPointMake(-60,-20) andDirection:YFEmitterParticleCellDirectionToBottom andRadious:9 andCellImg:nil];
    
    [YFEmitterCustomLayer leavesLayerInView:view atPosition:CGPointMake(-60,view.frame.size.height*0.33) andDirection:YFEmitterParticleCellDirectionToBottom andRadious:14 andCellImg:nil];
    
}

#pragma mark 雪花

+(void)snowLayerInView:(UIView *)view atPosition:(CGPoint)position andDirection:(YFEmitterParticleCellDirection)direction andRadious:(CGFloat)radious andCellImg:(NSString *)cellImg
{
    NSLog(@"调用了 - snowLayerInView");

    //创建雪花所在图层layer
    YFEmitterCustomLayer *snowLayer=[self addCustomLayerInView:view atPosition:position inSize:CGSizeMake(view.frame.size.width, view.frame.size.height)];
    
    //粒子
    YFEmitterSnowCell *emitterCell=[YFEmitterSnowCell snowCellWithCellImg:cellImg andRadious:radious andVelocity:20 andDirection:direction];
    
    snowLayer.emitterCells=@[emitterCell];
}


+(void)addSnowLayerInView:(UIView *)view
{
    NSLog(@"调用了 - addSnowLayerInView");
    //雪花粒子所在view,发射雪花的位置,雪花飘向的方向,雪花粒子半径,雪花粒子图片
    [YFEmitterCustomLayer snowLayerInView:view atPosition:CGPointMake(-60,-20) andDirection:YFEmitterParticleCellDirectionToBottom andRadious:19 andCellImg:nil];
    
    [YFEmitterCustomLayer snowLayerInView:view atPosition:CGPointMake(-60,-20) andDirection:YFEmitterParticleCellDirectionToBottom andRadious:9 andCellImg:nil];
    
    [YFEmitterCustomLayer snowLayerInView:view atPosition:CGPointMake(-60,view.frame.size.height*0.33) andDirection:YFEmitterParticleCellDirectionToBottom andRadious:14 andCellImg:nil];
    
}

#pragma mark 下雨

+(void)rainLayerInView:(UIView *)view atPosition:(CGPoint)position andDirection:(YFEmitterParticleCellDirection)direction andRadious:(CGFloat)radious andCellImg:(NSString *)cellImg
{
    //创建雨点所在图层layer
    YFEmitterCustomLayer *rainLayer=[self addCustomLayerInView:view atPosition:position inSize:CGSizeMake(view.frame.size.width, view.frame.size.height)];
    rainLayer.emitterPosition = CGPointMake(320 / 2.0, -30);
    rainLayer.emitterSize	  = CGSizeMake(320 * 2.0, 0);
    
    rainLayer.emitterMode   = kCAEmitterLayerOutline;
    rainLayer.emitterShape	= kCAEmitterLayerLine;
    
    rainLayer.shadowOpacity = 1.0;
    rainLayer.shadowRadius  = 0.0;
    rainLayer.shadowOffset  = CGSizeMake(0.0, 1.0);
    rainLayer.shadowColor   = [[UIColor whiteColor] CGColor];
    rainLayer.seed = (arc4random()%100)+1;
    
    //粒子
    YFEmitterRainCell *emitterCell = [YFEmitterRainCell rainCellWithCellImg:cellImg andRadious:radious andVelocity:20 andDirection:direction];

//    emitterCell.contents		= (id)[image CGImage];
    emitterCell.color			= [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];


    rainLayer.emitterCells=@[emitterCell];
}

+ (void)addRainLayerInView:(UIView *)view {
    
    [YFEmitterCustomLayer rainLayerInView:view atPosition:CGPointMake(160,120) andDirection:YFEmitterParticleCellDirectionToBottom andRadious:19 andCellImg:nil];
    
    [YFEmitterCustomLayer rainLayerInView:view atPosition:CGPointMake(-60,-20) andDirection:YFEmitterParticleCellDirectionToBottom andRadious:9 andCellImg:nil];

    [YFEmitterCustomLayer rainLayerInView:view atPosition:CGPointMake(-60,view.frame.size.height*0.33) andDirection:YFEmitterParticleCellDirectionToBottom andRadious:14 andCellImg:nil];
    
}



- (void)dealloc{
    NSLog(@"雪花粒子发射器销毁了");
}
@end
