//
//  Children_KVO.m
//  BigShow1949
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "Children_KVO.h"

@implementation Children_KVO

- (id) init{
    self = [super init];
    if(self != nil){
        //启动定时器
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        self.happyValue = 100;
        self.hurryValue = 100;
    }
    return self;
}

- (void)timerAction:(NSTimer *)timer{
    //使用set方法修改属性值，才能触发KVO
    [self setHappyValue:--_happyValue];
    
    [self setHurryValue:--_hurryValue];
}


@end
