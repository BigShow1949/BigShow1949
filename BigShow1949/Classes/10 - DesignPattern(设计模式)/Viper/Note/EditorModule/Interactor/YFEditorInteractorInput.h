//
//  YFEditorInteractorInput.h
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#ifndef YFEditorInteractorInput_h
#define YFEditorInteractorInput_h
@class YFNoteModel;
@protocol YFEditorInteractorInput <NSObject>
- (nullable YFNoteModel *)currentEditingNote;
- (void)storeCurrentEditingNote;

- (nullable NSString *)currentEditingNoteTitle;
- (nullable NSString *)currentEditingNoteContent;
@end
#endif /* YFEditorInteractorInput_h */
