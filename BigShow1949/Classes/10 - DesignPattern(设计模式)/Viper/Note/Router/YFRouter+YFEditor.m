//
//  YFRouter+YFEditor.m
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFRouter+YFEditor.h"
#import "YFEditorBuilder.h"

@implementation YFRouter (YFEditor)
+ (UIViewController *)viewForCreatingNoteWithDelegate:(id<YFEditorDelegate>)delegate {
    return [YFEditorBuilder viewForCreatingNoteWithDelegate:delegate router:[self new]];
}

+ (UIViewController *)viewForEditingNoteWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content delegate:(id<YFEditorDelegate>)delegate {
    return [YFEditorBuilder viewForEditingNoteWithUUID:uuid title:title content:content delegate:delegate router:[self new]];
}
@end
