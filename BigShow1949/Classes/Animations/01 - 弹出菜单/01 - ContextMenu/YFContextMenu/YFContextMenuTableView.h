//
//  YFContextMenuTableView.h
//  BigShow1949
//
//  Created by WangMengqi on 15/9/1.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YFContextMenuTableView;

@protocol YFContextMenuTableViewDelegate <NSObject>

@optional
- (void)contextMenuTableView:(YFContextMenuTableView *)contextMenuTableView didDismissWithIndexPath:(NSIndexPath *)indexPath;

@end


@interface YFContextMenuTableView : UITableView

@property (nonatomic) CGFloat animationDuration;

@property (nonatomic, copy) id<YFContextMenuTableViewDelegate>delegate;

- (instancetype)initWithTableViewDelegateDataSource:(id<UITableViewDelegate, UITableViewDataSource>)delegateDataSource;

- (void)showInView:(UIView *)superview withEdgeInsets:(UIEdgeInsets)edgeInsets animated:(BOOL)animated;

- (void)dismisWithIndexPath:(NSIndexPath *)indexPath;

- (void)updateAlongsideRotation;


@end
