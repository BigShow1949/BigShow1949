//
//  YFCounterPresenter.m
//  BigShow1949
//
//  Created by big show on 2018/10/15.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFCounterPresenter.h"

@implementation YFCounterPresenter
#pragma mark - Public
- (void)updateView {
    [self.delegateInteractor requestCount];
}

- (void)increment {
    [self.delegateInteractor increment];
}

- (void)decrement {
    [self.delegateInteractor decrement];
}

#pragma mark - YFCounterInteractorOutput
- (void)updateCount:(NSUInteger)count {
    [self.delegateView setCountText:[NSString stringWithFormat:@"%lu",(unsigned long)count]];
    [self.delegateView setDecrementEnabled:[self canDecrementCount:count]];
}

- (BOOL)canDecrementCount:(NSUInteger)count
{
    return (count > 0);
}
@end
