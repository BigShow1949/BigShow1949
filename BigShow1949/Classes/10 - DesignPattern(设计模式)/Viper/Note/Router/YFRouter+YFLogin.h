//
//  YFRouter+YFLogin.h
//  BigShow1949
//
//  Created by big show on 2018/12/11.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFRouter.h"
@protocol YFLoginViewDelegate;
@interface YFRouter (YFLogin)
+ (UIViewController *)loginViewWithMessage:(NSString *)message delegate:(id<YFLoginViewDelegate>)delegate;

@end
