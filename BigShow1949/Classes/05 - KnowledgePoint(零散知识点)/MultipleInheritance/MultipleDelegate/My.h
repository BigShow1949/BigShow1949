//
//  My.h
//  test2
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol MyDelegate
- (void)buyIphone:(NSString *)iphoneType money:(NSString *)money;

@end

@interface My : NSObject

@property(assign,nonatomic)id<MyDelegate> delegate;

- (void)willbuy;

- (void)buyIphone:(NSString *)iphoneType money:(NSString *)money;

@end
