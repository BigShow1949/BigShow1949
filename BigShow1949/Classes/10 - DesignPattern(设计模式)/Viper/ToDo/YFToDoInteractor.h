//
//  YFToDoInteractor.h
//  BigShow1949
//
//  Created by big show on 2018/12/7.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFToDoProtocols.h"
NS_ASSUME_NONNULL_BEGIN
@interface YFToDoInteractor : NSObject<ToDoInteractorInputProtocol>
@property (nonatomic, weak, nullable) id<ToDoInteractorOutputProtocol> output;

@end
NS_ASSUME_NONNULL_END
