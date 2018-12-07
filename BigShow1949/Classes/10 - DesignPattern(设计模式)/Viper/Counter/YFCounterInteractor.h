//
//  YFCounterInteractor.h
//  BigShow1949
//
//  Created by big show on 2018/10/15.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFCounterInteractorIO.h"
@interface YFCounterInteractor : NSObject<YFCounterInteractorInput>
@property (nonatomic, weak) id<YFCounterInteractorOutput> output;
@end
