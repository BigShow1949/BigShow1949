//
//  YFNoteListWireframe.h
//  BigShow1949
//
//  Created by big show on 2018/10/17.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFViperWireframe.h"

// 需要在这里写YFNoteListWireframeInput 这个协议吗？YFNoteListWireframeInput
@protocol YFEditorDelegate,YFLoginViewDelegate;// 这里会报错
@interface YFNoteListWireframe : NSObject <YFViperWireframe>
- (void)presentEditorForCreatingNewNoteWithDelegate:(id<YFEditorDelegate>)delegate completion:(void (^ __nullable)(void))completion;

@end
