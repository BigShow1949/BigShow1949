//
//  YFTNoteListModuleBuilder.h
//  BigShow1949
//
//  Created by big show on 2018/10/16.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol YFViperViewPrivate,YFNoteListDataService,YFNoteListRouter;
@interface YFTNoteListModuleBuilder : NSObject
+ (UIViewController *)viewControllerWithNoteListDataService:(id<YFViperViewPrivate>)service router:(id<YFNoteListRouter>)router;
+ (void)buildView:(id<YFViperViewPrivate>)view noteListDataService:(id<YFNoteListDataService>)service router:(id<YFNoteListRouter>)router;
@end
