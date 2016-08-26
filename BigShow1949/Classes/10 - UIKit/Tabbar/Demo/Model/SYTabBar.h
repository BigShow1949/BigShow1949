//
//  SYTabBar.h
//  31.3 - 主流框架
//
//  Created by apple on 15-3-6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class SYTabBar;
//@protocol SYTabBarDelegate <NSObject>
//
//@optional
//- (void)tabBar:(SYTabBar *)tabBar didSelectIndex:(NSUInteger)selIndex;
//
//@end

typedef void(^SYTabBarBlock) (NSInteger selectedIndex);
@interface SYTabBar : UIView
//@property (nonatomic, weak) id<SYTabBarDelegate> delegate;

@property (nonatomic, copy) SYTabBarBlock tabBarBlock;

+ (instancetype)tabBar;

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
@end
