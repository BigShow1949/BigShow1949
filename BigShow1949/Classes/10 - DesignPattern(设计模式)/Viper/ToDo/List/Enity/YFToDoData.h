//
//  YFToDoData.h
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFToDoData : NSObject
@property (nonatomic, readonly, copy,) NSArray*    sections;

+ (instancetype)dataWithSections:(NSArray *)sections;
@end
