//
//  SecondMenuData.h
//  MutableMenuTableView
//
//  Created by 张国庆 on 16/4/28.
//  Copyright © 2016年 zgq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyItem.h"

@interface SecondMenuData : NSObject

@property (nonatomic,strong) MyItem *item;
@property (nonatomic,strong) NSMutableArray *tableViewData;
@end
