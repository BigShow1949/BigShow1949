//
//  LoginPresenter.h
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginViewProtocol.h"
#import "LoginModel.h"
// P层
//中介(用于关联M层和V层)
@interface LoginPresenter : NSObject

//提供一个业务方法
- (void)loginWithName:(NSString*)name pwd:(NSString*)pwd;
- (void)attachView:(id<LoginViewProtocol>)loginView;
- (void)detachView;
@end
