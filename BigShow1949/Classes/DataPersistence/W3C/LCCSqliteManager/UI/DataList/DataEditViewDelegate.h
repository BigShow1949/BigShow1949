//
//  DataEditViewDelegate.h
//  BigShow1949
//
//  Created by zhht01 on 16/4/25.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#ifndef DataEditViewDelegate_h
#define DataEditViewDelegate_h


#import <Foundation/Foundation.h>

@protocol ProtocolDelegate <NSObject>

//// 必须实现的方法
//@required
//- (void)error;

// 可选实现的方法
@optional
- (void)other;
- (void)other2;
- (void)other3;

@end

#endif /* DataEditViewDelegate_h */
