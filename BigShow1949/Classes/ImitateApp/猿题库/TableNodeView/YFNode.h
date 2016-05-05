//
//  YFNode.h
//  YFTableNodeView
//
//  Created by zhht01 on 16/3/28.
//  Copyright © 2016年 BigShow1949. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFNode : NSObject

@property (nonatomic) int nodeLevel;//节点所在层次
@property (nonatomic) int nodeType;//节点类型
@property (nonatomic) id nodeData;//节点数据
@property (nonatomic) BOOL isExpanded;//节点是否展开
@property (nonatomic,strong) NSMutableArray *sonNodes;//子节点


@property (nonatomic, assign) NSString *title;

//@property (nonatomic, strong) NSMutableArray *dodes;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)nodeWithDict:(NSDictionary *)dict;
@end
