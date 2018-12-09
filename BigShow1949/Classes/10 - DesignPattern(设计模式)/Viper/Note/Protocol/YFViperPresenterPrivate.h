//
//  YFViperPresenterPrivate.m
//  BigShow1949
//
//  Created by big show on 2018/10/17.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFViperPresenter.h"
#import <Foundation/Foundation.h>

@protocol YFViperWireframe,YFViperView,YFViperInteractor;
// 宏空判断
@protocol YFViperPresenterPrivate <YFViperViewPrivate>
- (id<YFViperWireframe>)wireframe;
- (void)setWireframe:(id<YFViperWireframe>)wireframe;

- (void)setView:(id<YFViperView>)view;

- (id<YFViperInteractor>)interactor;
- (void)setInteractor:(id<YFViperInteractor>)interactor;

@end
