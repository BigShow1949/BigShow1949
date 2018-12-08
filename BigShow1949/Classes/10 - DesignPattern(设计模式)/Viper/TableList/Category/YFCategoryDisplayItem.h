//
//  YFCategoryDisplayItem.h
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFCategoryDisplayItem : NSObject
@property (nonatomic, copy) NSString *title;

+ (instancetype)itemWithTitle:(NSString *)title;
@end
