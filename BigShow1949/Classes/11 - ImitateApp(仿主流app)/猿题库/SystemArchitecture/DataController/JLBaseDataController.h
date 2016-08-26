//
//  JLBaseDataController.h
//  MVVM-DataController-Demo
//
//  Created by skyline on 16/3/15.
//  Copyright © 2016年 skyline. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^JLCompletionCallback)(NSError *);

@interface JLBaseDataController : NSObject

/** 网络请求，供子类调用*/
- (void)requestWithDataType:(NSString *)type;

@end
