//
//  LoginPresenter.m
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "LoginPresenter.h"


//P是中介(职责是用于关联M和V)
//P层需要:持有M层的引用和V层的引用(OOP)思想
@interface LoginPresenter ()
@property (nonatomic,strong) LoginModel *loginModel;
@property (nonatomic,strong) id<LoginViewProtocol> loginView;
@end


@implementation LoginPresenter
- (instancetype)init{
    self = [super init];
    if (self) {
        //持有M层的引用
        _loginModel = [[LoginModel alloc]init];
    }
    return self;
}
//提供绑定V层方法
//绑定
- (void)attachView:(id<LoginViewProtocol>)loginView{
    _loginView = loginView;
}
//解除绑定
- (void)detachView{
    _loginView = nil;
}
//实现业务方法
- (void)loginWithName:(NSString*)name pwd:(NSString*)pwd{
    [_loginModel loginWithName:name pwd:pwd callback:^(NSString *result) {
        if (_loginView != nil) {
            [_loginView onLoginResult:result];
        }
    }];
    
}


@end
