//
//  YFNoteListWireframeInput.h
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#ifndef YFNoteListWireframeInput_h
#define YFNoteListWireframeInput_h

@protocol YFEditorDelegate;
@protocol YFNoteListWireframeInput
- (void)presentEditorForCreatingNewNoteWithDelegate:(id<YFEditorDelegate>)delegate completion:(void (^ __nullable)(void))completion;
@end

#endif /* YFNoteListWireframeInput_h */
