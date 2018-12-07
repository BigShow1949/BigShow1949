//
//  YFCounterInteractor.m
//  BigShow1949
//
//  Created by big show on 2018/10/15.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFCounterInteractor.h"
@interface YFCounterInteractor()
@property (nonatomic, assign) NSUInteger count;
@end

@implementation YFCounterInteractor

#pragma mark - YFCounterInteractorInput
- (void)requestCount {
    [self sendCount];
}

- (void)increment {
    ++self.count;
    [self sendCount];
}

- (void)decrement {
    if ([self canDecrement]) {
        --self.count;
        [self sendCount];
    }
}
- (BOOL)canDecrement {
    return (self.count > 0);
}

- (void)sendCount {
    [self.output updateCount:self.count];
}
@end
