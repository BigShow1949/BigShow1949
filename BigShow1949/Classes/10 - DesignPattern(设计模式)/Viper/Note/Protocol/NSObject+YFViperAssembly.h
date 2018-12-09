//
//  NSObject+YFViperAssembly.h
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol YFViperViewPrivate,YFViperPresenterPrivate,YFViperInteractorPrivate,YFViperWireframePrivate,YFViperRouter;
@interface NSObject (YFViperAssembly)
+ (void)assembleViperForView:(id<YFViperViewPrivate>)view
                   presenter:(id<YFViperPresenterPrivate>)presenter
                  interactor:(id<YFViperInteractorPrivate>)interactor
                   wireframe:(id<YFViperWireframePrivate>)wireframe
                      router:(id<YFViperRouter>)router;
@end
