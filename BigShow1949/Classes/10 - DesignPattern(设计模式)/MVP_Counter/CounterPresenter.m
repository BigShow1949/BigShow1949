//
//  CounterPresenter.m
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "CounterPresenter.h"

@interface CounterPresenter () {
    id<CounterRepositoryProtocol> _counterRepository;
    id<CounterViewProtocol> _counterView;
}

@end

@implementation CounterPresenter

- (CounterPresenter *)initWithRepository:(id)counterRepository inView:(id)counterView {
    if (self = [super init]) {
        _counterRepository = counterRepository;
        _counterView = counterView;
    }
    return self;
}

#pragma mark - CounterPresenterProtocol Methods
- (void)getCurrentValue {
    NSInteger value = [_counterRepository getCurrentValue];
    [_counterView updateCounterValue:[NSString stringWithFormat:@"%ld", (long)value]];
}

- (void)incrementCounter {
    NSInteger value = [_counterRepository getCurrentValue];
    
    value = value + 1;
    
    [_counterRepository setCurrentValue:value];
    
    [_counterView updateCounterValue:[NSString stringWithFormat:@"%ld", (long)value]];
}

- (void)decrementCounter {
    
    NSInteger value = [_counterRepository getCurrentValue];
    
    value = value - 1;
    
    [_counterRepository setCurrentValue:value];
    
    [_counterView updateCounterValue:[NSString stringWithFormat:@"%ld", (long)value]];

}













@end
