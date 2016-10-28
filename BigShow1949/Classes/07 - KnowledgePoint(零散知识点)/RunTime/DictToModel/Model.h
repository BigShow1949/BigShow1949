//
//  Model.h
//  Cocopods
//
//  Created by 杨帆 on 16/7/6.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject


+ (instancetype)modelWithDict:(NSDictionary *)dict;

// 自动打印属性字符串
+ (void)resolveDict:(NSDictionary *)dict;
@end
