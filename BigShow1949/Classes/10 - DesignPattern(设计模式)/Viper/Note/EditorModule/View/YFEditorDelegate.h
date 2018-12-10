//
//  YFEditorDelegate.h
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#ifndef YFEditorDelegate_h
#define YFEditorDelegate_h

@class YFNoteModel;
@protocol YFEditorDelegate <NSObject>
- (void)editor:(UIViewController *)editor didFinishEditNote:(YFNoteModel *)note;
@end


#endif /* YFEditorDelegate_h */
