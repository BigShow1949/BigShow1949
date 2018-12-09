//
//  YFEditorBuilder.h
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YFEditorDelegate,YFViperRouter;
@interface YFEditorBuilder : NSObject
+ (UIViewController *)viewForCreatingNoteWithDelegate:(id<YFEditorDelegate>)delegate router:(id<YFViperRouter>)router;
+ (UIViewController *)viewForEditingNoteWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content delegate:(id<YFEditorDelegate>)delegate router:(id<YFViperRouter>)router;
@end
