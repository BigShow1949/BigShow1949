//
//  YFRouter+YFEditor.h
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFRouter.h"

@protocol YFEditorDelegate;
@interface YFRouter (YFEditor)
+ (UIViewController *)viewForCreatingNoteWithDelegate:(id<YFEditorDelegate>)delegate;
+ (UIViewController *)viewForEditingNoteWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content delegate:(id<YFEditorDelegate>)delegate;
@end
