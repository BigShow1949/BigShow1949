//
//  YFCategoryTableInteractor.m
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFCategoryTableInteractor.h"
#import "YFCategoryDisplayItem.h"

@implementation YFCategoryTableInteractor
-(NSMutableArray*)getAllCategories {
    YFCategoryDisplayItem *item0 = [YFCategoryDisplayItem itemWithTitle:@"0"];
    YFCategoryDisplayItem *item1 = [YFCategoryDisplayItem itemWithTitle:@"1"];
    YFCategoryDisplayItem *item2 = [YFCategoryDisplayItem itemWithTitle:@"2"];
    YFCategoryDisplayItem *item3 = [YFCategoryDisplayItem itemWithTitle:@"3"];
    YFCategoryDisplayItem *item4 = [YFCategoryDisplayItem itemWithTitle:@"4"];
    return @[item0,item1,item2,item3,item4];
}
@end
