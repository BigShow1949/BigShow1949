//
//  YFEditorViewEventHandler.h
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#ifndef YFEditorViewEventHandler_h
#define YFEditorViewEventHandler_h

@protocol YFViperRouter;
@protocol YFEditorViewEventHandler
- (void)didTouchNavigationBarDoneButton;
- (id<YFViperRouter>)router;
@end

#endif /* YFEditorViewEventHandler_h */
