//
//  MyItem.h
//  MutableMenuTableView
//
//  Created by 张国庆 on 16/4/27.
//  Copyright © 2016年 zgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyItem : NSObject

@property (nonatomic,strong) NSString *id_;
@property (nonatomic,strong) NSString *classId_;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) NSInteger level;
@property (nonatomic,strong) NSMutableArray *subItems;
@property (nonatomic,assign) BOOL isSubItemOpen;
@property (nonatomic,assign)BOOL isCascadeOpen;

@end
