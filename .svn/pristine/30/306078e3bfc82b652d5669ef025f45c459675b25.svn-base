//
//  YFBottomEditView.h
//  SmartingPark
//
//  Created by WangMengqi on 15/8/26.
//  Copyright (c) 2015年 智慧停车. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol YFBottomEditViewDelegate;

@interface YFBottomEditView : NSObject

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, assign) id <YFBottomEditViewDelegate> dataSource;

/**
 *  YFBottomEditView 背景颜色,默认为白色
 */
@property(nullable, nonatomic,copy) UIColor *backgroundColor;


/**
 *  显示bottomView
 *
 *  @param animated 是否需要动画(默认需要)
 */
- (void)show;
- (void)showWithAnimated:(BOOL)animated;


/**
 *  隐藏bottomView
 *
 *  @param animated 是否需要动画(默认需要)
 */
- (void)hidden;
- (void)hiddenWithAnimated:(BOOL)animated;





@end




@protocol YFBottomEditViewDelegate<NSObject>
@required

/**
 *  删除选中项
 */
- (void)deleteSelectItem;



@end

