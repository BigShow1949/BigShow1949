//
//  CounterRepository.h
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CounterRepositoryProtocol.h"
/*  M层
 主要提供数据的存储功能，一般都是用来封装网络获取的json数据的集合。Presenter通过调用Model进行对象交互。
 */
@interface CounterRepository : NSObject <CounterRepositoryProtocol>

@end
