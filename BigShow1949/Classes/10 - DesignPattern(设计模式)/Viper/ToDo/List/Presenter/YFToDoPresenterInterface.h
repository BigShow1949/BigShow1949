//
//  YFToDoPresenterInterface.h
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#ifndef YFToDoPresenterInterface_h
#define YFToDoPresenterInterface_h

@protocol YFToDoPresenterDelegate
- (void)updateView;
- (void)addNewEntry;
@end

#endif /* YFToDoPresenterInterface_h */
