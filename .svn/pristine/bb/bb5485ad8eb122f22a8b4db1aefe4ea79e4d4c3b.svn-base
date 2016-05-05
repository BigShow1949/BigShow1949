//
//  MAMapServices.h
//  MapKit_static
//
//  Created by AutoNavi.
//  Copyright (c) 2013年 AutoNavi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAMapServices : NSObject

+ (MAMapServices *)sharedServices;

/// API Key, 在创建MAMapView之前需要先绑定key.
@property (nonatomic, copy) NSString *apiKey;

/// SDK 版本号, 形式如v3.0.0
@property (nonatomic, readonly) NSString *SDKVersion;

/**
 *  是否启用崩溃日志上传。默认为YES。
 *  开启崩溃日志上传有助于我们更好的了解SDK的状况，可以帮助我们持续优化和改进SDK。
 *  需要注意的是，我是通过设置NSUncaughtExceptionHandler来捕获异常的，如果您的APP中使用了其他手机崩溃日志的SDK，或者自己有设置NSUncaughtExceptionHandler的话，请保证MAMapServices的初始化是在其他设置NSUncaughtExceptionHandler操作之后进行的，我们的handler会再处理完异常后调用前一次设置的handler，保证之前设置的handler会被执行。
 */
@property (nonatomic, assign) BOOL crashReportEnabled;


@end
