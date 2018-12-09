//
//  YFViperViewPrivate.m
//  BigShow1949
//
//  Created by big show on 2018/10/17.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//


#import "YFViperView.h"
#import <Foundation/Foundation.h>


@protocol YFViperViewEventHandler;
@protocol YFViperViewPrivate <YFViperView>

- (id<YFViperViewEventHandler>)eventHandler;
- (void)setEventHandler:(id<YFViperViewEventHandler>)eventHandler;

@optional
- (id)viewDataSource;
- (void)setViewDataSource:(id)viewDataSource;
- (void)setRouteSource:(UIViewController *)routeSource;

@end
