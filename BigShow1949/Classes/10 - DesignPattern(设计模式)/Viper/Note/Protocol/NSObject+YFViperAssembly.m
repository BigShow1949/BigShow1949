//
//  NSObject+YFViperAssembly.m
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "NSObject+YFViperAssembly.h"

#import "YFViperViewPrivate.h"
#import "YFViperPresenterPrivate.h"
#import "YFViperInteractorPrivate.h"
#import "YFViperWireframePrivate.h"
#import "YFViperRouter.h"

@implementation NSObject (YFViperAssembly)
+ (void)assembleViperForView:(id<YFViperViewPrivate>)view
                   presenter:(id<YFViperPresenterPrivate>)presenter
                  interactor:(id<YFViperInteractorPrivate>)interactor
                   wireframe:(id<YFViperWireframePrivate>)wireframe
                      router:(id<YFViperRouter>)router {
    //*
//    NSParameterAssert([view conformsToProtocol:@protocol(YFViperViewPrivate)]);
//    NSParameterAssert([presenter conformsToProtocol:@protocol(YFViperPresenterPrivate)]);
//    NSParameterAssert([interactor conformsToProtocol:@protocol(YFViperInteractorPrivate)]);
//    NSParameterAssert([wireframe conformsToProtocol:@protocol(YFViperWireframePrivate)]);
//    NSCParameterAssert([router conformsToProtocol:@protocol(YFViperRouter)]);
    
    // 为什么就是不识别？
//    [interactor conformsToProtocol:@protocol(YFViperInteractorPrivate)];

//    NSAssert3(interactor.eventHandler == nil, @"Interactor (%@)'s eventHandler (%@) already exists when assemble viper for new eventHandler", interactor, interactor.eventHandler,presenter);
//    NSAssert3(interactor.dataSource == nil, @"Interactor (%@)'s dataSource (%@) already exists when assemble viper for new dataSource", interactor, interactor.dataSource,presenter);
    
    [interactor setEventHandler:presenter];
    [interactor setDataSource:presenter];

//    NSAssert3(wireframe.view == nil, @"Wireframe (%@)'s view (%@) already exists when assemble viper for new view", wireframe, wireframe.view,view);
    
    [wireframe setView:view];
    [wireframe setRouter:router];
    
//    NSAssert3(presenter.interactor == nil, @"Presenter (%@)'s interactor (%@) already exists when assemble viper for new interactor", presenter, presenter.interactor,interactor);
//    NSAssert3(presenter.view == nil, @"Presenter (%@)'s view (%@) already exists when assemble viper for new view", presenter, presenter.view,view);
//    NSAssert3(presenter.wireframe == nil, @"Presenter (%@)'s wireframe (%@) already exists when assemble viper for new router", presenter, presenter.wireframe,self);
    
    [presenter setInteractor:interactor];
    [presenter setView:view];
    [presenter setWireframe:wireframe];

    if ([view respondsToSelector:@selector(viewDataSource)] &&
        [view respondsToSelector:@selector(setViewDataSource:)]) {
        NSAssert3(view.viewDataSource == nil, @"View (%@)'s viewDataSource (%@) already exists when assemble viper for new viewDataSource", view, view.viewDataSource,presenter);
        view.viewDataSource = presenter;
    }
    NSAssert3(view.eventHandler == nil, @"View (%@)'s eventHandler (%@) already exists when assemble viper for new eventHandler", view, view.eventHandler,presenter);
    [view setEventHandler:presenter];
    // */
}
@end
