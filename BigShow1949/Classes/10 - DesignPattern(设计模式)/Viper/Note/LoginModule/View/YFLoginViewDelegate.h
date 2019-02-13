//
//  YFLoginViewDelegate.h
//  BigShow1949
//
//  Created by big show on 2018/12/11.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#ifndef YFLoginViewDelegate_h
#define YFLoginViewDelegate_h
@protocol YFLoginViewDelegate <NSObject>
@optional
- (void)loginViewController:(UIViewController *)loginViewController didLoginWithAccount:(NSString *)account;
@end

#endif /* YFLoginViewDelegate_h */
