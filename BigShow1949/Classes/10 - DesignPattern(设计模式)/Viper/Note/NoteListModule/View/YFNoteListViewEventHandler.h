//
//  YFNoteListViewEventHandler.h
//  BigShow1949
//
//  Created by big show on 2018/10/18.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "YFViperViewEventHandler.h"

@protocol YFNoteListViewEventHandler <YFViperViewEventHandler,UIViewControllerPreviewingDelegate>
- (void)didTouchNavigationBarAddButton;

- (BOOL)canEditRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)handleDeleteCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)handleDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
