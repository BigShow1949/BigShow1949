//
//  YFToDoData.m
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFToDoData.h"

@interface YFToDoData ()
@property (nonatomic, copy) NSArray*    sections;

@end

@implementation YFToDoData
+ (instancetype)dataWithSections:(NSArray *)sections {
    YFToDoData* data = [[YFToDoData alloc] init];
    data.sections = sections;
    return data;
}
@end
