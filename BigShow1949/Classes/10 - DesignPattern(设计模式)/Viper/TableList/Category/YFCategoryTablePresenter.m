//
//  YFCategoryTablePresenter.m
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFCategoryTablePresenter.h"
#import "YFCategoryTableViewControllerProtocol.h"
#import "YFCategoryTableInteractor.h"
#import "YFCategoryTableWireframe.h"
@implementation YFCategoryTablePresenter

- (void)configureData {
    NSArray *arr = [self.interactor getAllCategories];
    [self.categoryView updateTableView:arr];
}

- (void)jumpToNews:(int)categoryIndex {
    [self.wireframe jumpToNews:categoryIndex];
}

@end
