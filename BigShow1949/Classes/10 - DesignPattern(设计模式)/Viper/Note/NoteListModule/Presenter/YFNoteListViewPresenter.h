//
//  YFNoteListViewPresenter.h
//  BigShow1949
//
//  Created by big show on 2018/10/16.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "YFViperViewEventHandler.h"
#import "YFViperPresenter.h"
#import "YFNoteListViewDataSource.h"
#import "YFNoteListViewEventHandler.h"

@interface YFNoteListViewPresenter : NSObject<YFViperPresenter,YFNoteListViewEventHandler,YFNoteListViewDataSource>
@end
