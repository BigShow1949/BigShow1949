//
//  YFLoginBuilder.h
//  BigShow1949
//
//  Created by big show on 2018/12/11.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol YFLoginViewDelegate,YFViperRouter;
@interface YFLoginBuilder : NSObject
+ (UIViewController *)viewWithMessage:(NSString *)message delegate:(id<YFLoginViewDelegate>)delegate router:(id<YFViperRouter>)router;

@end
