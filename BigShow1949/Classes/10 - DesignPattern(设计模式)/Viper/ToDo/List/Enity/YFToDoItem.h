//
//  YFToDoItem.h
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFToDoItem : NSObject
@property (nonatomic, readonly, copy)   NSString*   title;
@property (nonatomic, readonly, copy)   NSString*   dueDay;

+ (instancetype)itemWithTitle:(NSString*)title dueDay:(NSString*)dueDay;
@end
