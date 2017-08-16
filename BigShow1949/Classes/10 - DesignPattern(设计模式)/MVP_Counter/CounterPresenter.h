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

/* P层
 作为model和view的中间人，从model层获取数据之后传给view，使得View和model没有耦合。
 */
@interface CounterPresenter : NSObject<CounterPresenterProtocol>


- (CounterPresenter *)initWithRepository:(id<CounterRepositoryProtocol>)counterRepository inView:(id<CounterViewProtocol>)counterView;
@end
