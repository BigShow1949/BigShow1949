//
//  YFToDoItem.m
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFToDoItem.h"

@interface YFToDoItem()

@property (nonatomic, copy) NSString*title;
@property (nonatomic, copy) NSString*dueDay;
@end

@implementation YFToDoItem
+ (instancetype)itemWithTitle:(NSString*)title dueDay:(NSString*)dueDay {
    YFToDoItem *item = [[YFToDoItem alloc] init];
    item.title = title;
    item.dueDay = dueDay;
    return item;
}
@end
