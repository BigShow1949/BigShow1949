//
//  YFViperInteractor.m
//  BigShow1949
//
//  Created by big show on 2018/10/17.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol YFViperInteractor<NSObject>
@property (nonatomic, readonly, weak) id dataSource;
@property (nonatomic, readonly, weak) id eventHandler;
@end
