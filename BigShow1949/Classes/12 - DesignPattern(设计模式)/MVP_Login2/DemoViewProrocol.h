//
//  DemoViewProrocol.h
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DemoViewProrocol <NSObject>

//
- (void) showPasswordInvalidInfo;

//网络返回
- (void) onRequestStart;
- (void) onRequestSuccess;
- (void) onRequestError;

@end
