//
//  CounterRepository.m
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "CounterRepository.h"

@implementation CounterRepository

-(NSInteger)getCurrentValue {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"CounterValueKey"];
}

-(void)setCurrentValue:(NSInteger)value {
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:@"CounterValueKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
