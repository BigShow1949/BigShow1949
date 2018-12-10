//
//  YFEditorViewController.h
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFEditorViewProtocol.h"
#import "YFViperView.h"
@protocol YFEditorDelegate;
@interface YFEditorViewController : UIViewController<YFViperView,YFEditorViewProtocol>
@property (nonatomic, weak) id<YFEditorDelegate> delegate;
@property (nonatomic, assign) YFEditorMode editMode;

@end
