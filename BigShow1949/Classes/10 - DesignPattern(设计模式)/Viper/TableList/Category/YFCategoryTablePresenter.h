//
//  YFCategoryTablePresenter.h
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol YFCategoryTableViewControllerDelegate;
@class YFCategoryTableWireframe;
@class YFCategoryTableInteractor;
@interface YFCategoryTablePresenter : NSObject

@property (nonatomic, weak) id<YFCategoryTableViewControllerDelegate> categoryView;
@property (nonatomic, strong) YFCategoryTableWireframe *wireframe;
@property (nonatomic, strong) YFCategoryTableInteractor *interactor;

- (void)configureData;
- (void)jumpToNews:(int)categoryIndex;
@end
