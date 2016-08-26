//
//  JCFlipPageView.h
//  JCFlipPageView
//
//  Created by Jimple on 14-8-7.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCFlipPage;
@protocol JCFlipPageViewDataSource;
@interface JCFlipPageView : UIView

@property (nonatomic, weak) id<JCFlipPageViewDataSource> dataSource;

@property (nonatomic, assign) BOOL cachePageSnapshotImage;  // 是否缓存页面截图

- (NSInteger)currPageIndex;
- (void)reloadData;

- (void)flipToPageAtIndex:(NSUInteger)pageNumber animation:(BOOL)animation;
- (void)flipToPageAtIndex:(NSUInteger)pageNumber animation:(BOOL)animation duration:(CGFloat)duration;

- (JCFlipPage *)dequeueReusablePageWithReuseIdentifier:(NSString *)reuseIdentifier;

- (void)initializeBackgroundPageView:(UIView *)bgView;
- (void)initializeBackgroundPageViewWithBgColor:(UIColor *)bgColor;


@end

@protocol JCFlipPageViewDataSource <NSObject>

- (NSUInteger)numberOfPagesInFlipPageView:(JCFlipPageView *)flipPageView;
- (JCFlipPage *)flipPageView:(JCFlipPageView *)flipPageView pageAtIndex:(NSUInteger)index;

@end
