//
//  YFNode.m
//  YFTableNodeView
//
//  Created by zhht01 on 16/3/28.
//  Copyright © 2016年 BigShow1949. All rights reserved.
//

#import "YFNode.h"

@implementation YFNode


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
        
        self.title = dict[@"title"];
        self.sonNodes = dict[@"sonNode"];
        self.isExpanded = NO;
        
//        NSLog(@"title = %@", self.title);
//        NSLog(@"sonNodes = %@", self.sonNodes);
        
        // 2. 处理特殊的属性 friends
        NSMutableArray *tempArray = [NSMutableArray array];

        for (NSDictionary *dict in self.sonNodes) {
            YFNode *sonNode = [YFNode nodeWithDict:dict];
            [tempArray addObject:sonNode];
        }
        
        self.sonNodes = tempArray;
        
    }
    
    return self;
}

+ (instancetype)nodeWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


//- (NSMutableArray *)sonNodes {
//
//    if (!_sonNodes) {
//        _sonNodes = [NSMutableArray array];
//    }
//    return _sonNodes;
//}


@end
