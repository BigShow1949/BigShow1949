//
//  YFNoteListWireframeInput.h
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#ifndef YFNoteListWireframeInput_h
#define YFNoteListWireframeInput_h

@protocol YFEditorDelegate,YFLoginViewDelegate;
@protocol YFNoteListWireframeInput
- (void)presentLoginViewWithMessage:(NSString *)message delegate:(id<YFLoginViewDelegate>)delegate completion:(void (^ __nullable)(void))completion;

- (void)presentEditorForCreatingNewNoteWithDelegate:(id<YFEditorDelegate>)delegate completion:(void (^ __nullable)(void))completion;
- (void)quitEditorViewWithAnimated:(BOOL)animated;
- (void)pushEditorViewForEditingNoteWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content delegate:(id<YFEditorDelegate>)delegate;

@end

#endif /* YFNoteListWireframeInput_h */
