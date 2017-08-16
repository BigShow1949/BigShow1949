//
//  HttpClient.h
//  MVP
//
//  Created by baoshan on 17/2/8.
//  Copyright © 2017年 hans. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpResponseHandle;

@interface HttpClient : NSObject

//初始化方法
- (instancetype)initWithHandle:(id<HttpResponseHandle>) responseHandle;
- (void)post:(NSString *)URLString parameters:(id)parameters;
- (void)get:(NSString *)URLString parameters:(id)parameters;
@end
