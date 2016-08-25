//
//  YFFlexView.h
//  BigShow1949
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DraggableView;
@class PaneBehavior;


typedef NS_ENUM(NSInteger, PaneState) {
    PaneStateOpen,
    PaneStateClosed,
};


@interface YFFlexView : UIView
@property (nonatomic, readonly) PaneState paneState;
@end
