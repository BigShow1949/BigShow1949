//
//  HttpUtils.m
//  Dream_Architect_MVP_OC
//
//  Created by Apple on 2017/2/7.
//  Copyright © 2017年 乔布永. All rights reserved.
//

#import "HttpUtils.h"

@implementation HttpUtils
+ (void)postWithName:(NSString*)name pwd:(NSString*)pwd callback:(Callback)callback{
    //发起网络请求
    //第三方框架(这地方网络框架既能调用系统,又能调用第三方的框架)
    //希望做一个这样的处理(方便后期的维护和扩展)
    //直接调用系统吧
    //第一步:
    NSURL *url = [NSURL URLWithString:@"http://42.120.11.155/index.php?m=home&c=user&a=login"];
    //第二步:
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    //第三步:
    request.HTTPMethod = @"POST";
    NSString *params  = [NSString stringWithFormat:@"mobile=%@&password=%@",name,pwd];
    request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
    //第四步:
    //创建请求会话
    NSURLSession *session = [NSURLSession sharedSession];
    //第五步:创建请求任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       //第七步:处理请求结果
        if (error!=nil) {
            NSLog(@"登录失败");
        }else{
            
            NSLog(@"登录成功");
            //回调
            NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            callback(result);
            
        }
    }];
//    第六步:执行任务
    [task resume];
    
}

@end
