//
//  HHHeaderView.h
//  HHHorizontalPagingView
//
//  Created by Huanhoo on 15/7/16.
//  Copyright (c) 2015年 Huanhoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHHeaderView : UIView

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *headerTopConstraint;
@property (nonatomic, weak) IBOutlet UIImageView *headerImageView;
@property (nonatomic, weak) IBOutlet UIView *segmentView;

+ (HHHeaderView *)headerView;

@end
