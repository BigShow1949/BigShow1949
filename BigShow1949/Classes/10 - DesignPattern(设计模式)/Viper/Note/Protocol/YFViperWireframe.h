//
//  YFViperWireframe.m
//  BigShow1949
//
//  Created by big show on 2018/10/17.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol YFViperView;
@protocol YFViperWireframe<NSObject>
@property (nonatomic, readonly,weak) id<YFViperView> view;
@end
