//
//  YFCategoryDisplayItem.m
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFCategoryDisplayItem.h"

@implementation YFCategoryDisplayItem
+ (instancetype)itemWithTitle:(NSString *)title {
    YFCategoryDisplayItem *item = [[YFCategoryDisplayItem alloc] init];
    item.title = title;
    return item;
}
@end
