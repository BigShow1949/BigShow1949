//
//  YFCounterPresenter.h
//  BigShow1949
//
//  Created by big show on 2018/10/15.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFCounterInteractorIO.h"
#import "YFCounterView.h"

@interface YFCounterPresenter : NSObject<YFCounterInteractorOutput>
@property (nonatomic, weak) id<YFCounterView> delegateView;
@property (nonatomic, strong) id<YFCounterInteractorInput> delegateInteractor;
// 这里为什么要用storng，见VC注释

- (void)updateView;
- (void)increment;
- (void)decrement;
@end
