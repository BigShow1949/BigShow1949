//
//  Depart.h
//  JKBaseModel
//
//  Created by zx_04 on 15/6/30.
//  Copyright (c) 2015年 joker. All rights reserved.
//

#import "JKDBModel.h"

@interface Depart : JKDBModel

/** 部门编号 */
@property (nonatomic, copy)     NSString                    *departNum;
/** 部门名称 */
@property (nonatomic, copy)     NSString                    *departName;

@end
