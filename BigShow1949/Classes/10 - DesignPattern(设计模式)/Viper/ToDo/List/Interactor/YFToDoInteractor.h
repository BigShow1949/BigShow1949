//
//  YFToDoInteractor.h
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFToDoInteractorInterface.h"

@interface YFToDoInteractor : NSObject <YFToDoInteractorInput>
@property (nonatomic, weak) id<YFToDoInteractorOutput> output;
@end
