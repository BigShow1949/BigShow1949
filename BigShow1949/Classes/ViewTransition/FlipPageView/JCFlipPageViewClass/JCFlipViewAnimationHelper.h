//
//  JCFlipViewAnimationHelper.h
//  JCFlipPageView
//
//  Created by Jimple on 14-8-8.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EFlipDirection)
{
    kEFlipDirectionToPrePage               = 0,
    kEFlipDirectionToNextPage
};

@protocol JCFlipViewAnimationHelperDataSource;
@protocol JCFlipViewAnimationHelperDelegate;
@interface JCFlipViewAnimationHelper : NSObject

@property (nonatomic, weak) id<JCFlipViewAnimationHelperDataSource> dataSource;
@property (nonatomic, weak) id<JCFlipViewAnimationHelperDelegate> delegate;

- (instancetype)initWithHostView:(UIView *)hostView backgroundPageView:(UIView *)bgPageView;
- (void)resetBackgroundPageView:(UIView *)bgView;

- (void)flipToDirection:(EFlipDirection)direction toPageNum:(NSUInteger)pageNum;
- (void)flipToDirection:(EFlipDirection)direction toPageNum:(NSUInteger)pageNum duration:(CGFloat)duration;


@end

@protocol JCFlipViewAnimationHelperDataSource <NSObject>

- (UIView *)flipViewAnimationHelperGetPreView:(JCFlipViewAnimationHelper *)helper;
- (UIView *)flipViewAnimationHelperGetCurrentView:(JCFlipViewAnimationHelper *)helper;
- (UIView *)flipViewAnimationHelperGetNextView:(JCFlipViewAnimationHelper *)helper;

- (UIView *)flipViewAnimationHelper:(JCFlipViewAnimationHelper *)helper getPageByNum:(NSUInteger)pageNum;

- (NSInteger)flipViewAnimationHelperGetCurrentPageIndex:(JCFlipViewAnimationHelper *)helper;
- (UIImage *)flipViewAnimationHelper:(JCFlipViewAnimationHelper *)helper getSnapshotForPageIndex:(NSInteger)index;



@end

@protocol JCFlipViewAnimationHelperDelegate <NSObject>

- (void)flipViewAnimationHelperBeginAnimation:(JCFlipViewAnimationHelper *)helper;
- (void)flipViewAnimationHelperEndAnimation:(JCFlipViewAnimationHelper *)helper;

- (void)flipViewAnimationHelper:(JCFlipViewAnimationHelper *)helper flipCompletedToDirection:(EFlipDirection)direction;
- (void)flipViewAnimationHelper:(JCFlipViewAnimationHelper *)helper flipCompletedToPage:(NSUInteger)pageNum;

- (void)flipViewAnimationHelper:(JCFlipViewAnimationHelper *)helper pageSnapshot:(UIImage *)snapshot forPageIndex:(NSInteger)index;

@end
