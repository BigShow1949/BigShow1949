//
//  DemoPresenterProtocol.h
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoViewModel.h"
@protocol DemoPresenterProtocol <NSObject>

- (void) doLoginRequest:(DemoViewModel*)viewModel;
@end
