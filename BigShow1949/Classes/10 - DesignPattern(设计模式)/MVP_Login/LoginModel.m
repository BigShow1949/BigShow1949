//
//  LoginModel.m
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
- (void)loginWithName:(NSString*)name pwd:(NSString*)pwd callback:(Callback)callback{
    //实现功能
    //例如:访问网络?访问数据库?
    //数据曾划分了模块()
    [HttpUtils postWithName:name pwd:pwd callback:^(NSString *result) {
        //解析json ,xml数据
        //然后保存数据库
        //中间省略100行代码
        callback(result);//返回数据回调
    }];
}

@end
