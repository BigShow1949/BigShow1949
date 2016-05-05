//
//  TableViewModel.h
//  MVVMDemo
//
//  Created by coderyi on 15/6/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^callback) (NSArray *array);

@interface YiTableViewModel : NSObject

//tableView头部刷新的网络请求
- (void)headerRefreshRequestWithCallback:(callback)callback;
//tableView底部刷新的网络请求
- (void)footerRefreshRequestWithCallback:(callback)callback;

@end
