//
//  YFEditorInteractorDataSource.h
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#ifndef YFEditorInteractorDataSource_h
#define YFEditorInteractorDataSource_h

@protocol YFEditorInteractorDataSource <NSObject>
- (nullable NSString *)currentEditingNoteTitle;
- (nullable NSString *)currentEditingNoteContent;
@end

#endif /* YFEditorInteractorDataSource_h */
