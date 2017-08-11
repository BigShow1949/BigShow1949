//
//  LoginModel.h
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpUtils.h"

//M层(数据层,数据库,网络,文件等...)
@interface LoginModel : NSObject
//业务方法
- (void)loginWithName:(NSString*)name pwd:(NSString*)pwd callback:(Callback)callback;
@end
