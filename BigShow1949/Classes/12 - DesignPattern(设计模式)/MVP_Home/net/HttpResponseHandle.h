//
//  HttpResponseHandle.h
//  MVP
//
//  Created by baoshan on 17/2/8.
//  Copyright © 2017年 hans. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpResponseHandle <NSObject>

@required


/**
 响应成功

 @param responseObject 返回的数据
 */
- (void)onSuccess:(id)responseObject;

/**
 响应失败

 @param clientInfo 返回的数据
 @param errCode    业务错误码
 @param errInfo    错误信息
 */
- (void)onFail:(id)clientInfo
        errCode:(NSInteger)errCode
       errInfo:(NSString *)errInfo;
@end
