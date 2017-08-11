//
//  CounterPresenter.h
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CounterViewProtocol.h"
#import "CounterPresenterProtocol.h"
#import "CounterRepositoryProtocol.h"


// P层
@interface CounterPresenter : NSObject<CounterPresenterProtocol>


- (CounterPresenter *)initWithRepository:(id<CounterRepositoryProtocol>)counterRepository inView:(id<CounterViewProtocol>)counterView;
@end
