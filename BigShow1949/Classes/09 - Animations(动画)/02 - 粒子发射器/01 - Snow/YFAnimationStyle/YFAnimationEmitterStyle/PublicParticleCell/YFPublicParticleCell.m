//
//  PublicParticleCell.m
//  YFAnimationStyle
//
//  Created by ykh on 15/5/28.
//  Copyright (c) 2015年 YKH. All rights reserved.
//

#import "YFPublicParticleCell.h"

@implementation YFPublicParticleCell
-(instancetype)init{
    
    if (self=[super init]) {
        //创建雪花形状的粒子
        self = (YFPublicParticleCell *)[CAEmitterCell emitterCell];
        //粒子的名字
        self.name = @"snow";
        //粒子参数的速度乘数因子
        
        //产生粒子的速率,应该采用外部设置
        self.birthRate = 1.5;
        //粒子的生命周期
        self.lifetime = 60.0;
        //粒子速度,采用外部设置
        //粒子的速度变化范围
        self.velocityRange = self.velocity;
        //自旋转角度范围
        self.spinRange = 0.5 * M_PI;
        
    }
    return self;
}


@end
