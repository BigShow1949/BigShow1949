//
//  YFLoginBuilder.m
//  BigShow1949
//
//  Created by big show on 2018/12/11.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFLoginBuilder.h"

#import "YFLoginViewController.h"
#import "YFLoginViewPresenter.h"
#import "YFLoginInteractor.h"
#import "YFLoginViewWireframe.h"

#import "NSObject+YFViperAssembly.h"

@implementation YFLoginBuilder
+ (UIViewController *)viewWithMessage:(NSString *)message delegate:(id<YFLoginViewDelegate>)delegate router:(id<YFViperRouter>)router {
    
    YFLoginViewController *view = [[YFLoginViewController alloc] init];
    view.delegate = delegate;
    view.message = message;
    [self buildView:(id<YFViperViewPrivate>)view router:router];

    return view;
}

+ (void)buildView:(id<YFViperViewPrivate>)view router:(id<YFViperRouter>)router {
    YFLoginViewPresenter *presenter = [[YFLoginViewPresenter alloc] init];
    YFLoginInteractor *interactor = [[YFLoginInteractor alloc] init];
    id<YFViperWireframePrivate> wireframe = (id)[[YFLoginViewWireframe alloc] init];
    
    [self assembleViperForView:view
                     presenter:(id<YFViperPresenterPrivate>)presenter
                    interactor:(id<YFViperInteractorPrivate>)interactor
                     wireframe:(id<YFViperWireframePrivate>)wireframe
                        router:(id<YFViperRouter>)router];
}

@end
