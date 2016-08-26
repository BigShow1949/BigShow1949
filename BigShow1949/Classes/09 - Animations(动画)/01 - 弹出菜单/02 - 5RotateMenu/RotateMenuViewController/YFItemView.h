//
//  YFItemView.h
//  BigShow1949
//
//  Created by WangMengqi on 15/9/1.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YFItemViewDelegate <NSObject>

- (void)didTapped:(NSInteger)tag;

@end


@interface YFItemView : UIButton

@property (nonatomic, weak) id <YFItemViewDelegate>delegate;

- (instancetype)initWithNormalImage:(NSString *)normal highlightedImage:(NSString *)highlighted tag:(NSInteger)tag title:(NSString *)title;

@end