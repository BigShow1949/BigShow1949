//
//  DemoPresenter.m
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "DemoPresenter.h"

@implementation DemoPresenter

- (void) doLoginRequest:(DemoViewModel*)viewModel {
    
    if ([viewModel isPasswordValid]) {
        //自定义业务
        
        //这段可以假设网络请求开始以后的回调
        if ([self.viewDelegate respondsToSelector:@selector(onRequestStart)] ) {
            [self.viewDelegate onRequestStart];
        }
        // 模拟网络请求耗时
        sleep(3);
        
        // 模拟网络请求成功
        if ([self.viewDelegate respondsToSelector:@selector(onRequestSuccess)] ) {
            [self.viewDelegate onRequestSuccess];
        }
    }else {
        if ([self.viewDelegate respondsToSelector:@selector(showPasswordInvalidInfo)]) {
            [self.viewDelegate showPasswordInvalidInfo];
        }
    }
}

@end
