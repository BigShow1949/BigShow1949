//
//  DemoPresenter.h
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DemoViewProrocol.h"
#import "DemoPresenterProtocol.h"

@interface DemoPresenter : NSObject<DemoPresenterProtocol>

@property (nonatomic, weak) id<DemoViewProrocol>viewDelegate;

@end
