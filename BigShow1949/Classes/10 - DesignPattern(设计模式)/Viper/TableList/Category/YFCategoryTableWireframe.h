//
//  YFCategoryTableWireframe.h
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YFCategoryTablePresenter;
@interface YFCategoryTableWireframe : NSObject

@property (nonatomic, strong) YFCategoryTablePresenter *presenter;


//- (void)presentInterfaceFromController:(UINavigationController *)navigationController;

- (void)pushViewController:(UIViewController *)destination fromViewController:(UIViewController *)source;

- (void)jumpToNews:(int)categoryIndex;
@end
