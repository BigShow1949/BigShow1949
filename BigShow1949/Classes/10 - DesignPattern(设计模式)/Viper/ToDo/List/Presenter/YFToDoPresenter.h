//
//  YFToDoPresenter.h
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFToDoInteractorInterface.h"
#import "YFToDoPresenterInterface.h"
#import "YFToDoViewControllerInterface.h"
@class YFToDoWireframe;
@interface YFToDoPresenter : NSObject<YFToDoPresenterDelegate,YFToDoInteractorOutput>

@property (nonatomic, strong) YFToDoWireframe *wireframe;
@property (nonatomic, strong) id<YFToDoInteractorInput> interactor;

@property (nonatomic, strong) UIViewController<YFToDoViewControllerDelegate> *viewController;


//@property (nonatomic, strong) UIViewController<VTDListViewInterface> *userInterface;

@end
