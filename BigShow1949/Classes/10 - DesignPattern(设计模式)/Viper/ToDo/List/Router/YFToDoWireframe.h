//
//  YFToDoWireframe.h
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YFToDoPresenter;
@interface YFToDoWireframe : NSObject
@property (nonatomic, strong) YFToDoPresenter *presenter;

- (void)presentListInterfaceFromVC:(UIViewController *)vc;


- (void)pushViewController:(UIViewController *)destination fromViewController:(UIViewController *)source;
@end
