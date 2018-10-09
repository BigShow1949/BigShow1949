//
//  ScrollMenuStyleVC.m
//  YNPageViewController
//
//  Created by ZYN on 2018/6/25.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "YNScrollMenuStyleVC.h"
#import "YNPageScrollMenuView.h"
#import "YNPageConfigration.h"
#import "UIView+YNPageExtend.h"

@interface YNScrollMenuStyleVC ()<YNPageScrollMenuViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation YNScrollMenuStyleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, YFScreen.width, self.view.frame.size.height)];
    _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    /// style 1
    YNPageConfigration *style_config_1 = [YNPageConfigration defaultConfig];
    YNPageScrollMenuView *style_1 = [YNPageScrollMenuView pagescrollMenuViewWithFrame:CGRectMake(0, 0, YFScreen.width, 44) titles:@[@"JAVA", @"Object-C", @"JS"].mutableCopy configration:style_config_1 delegate:self currentIndex:0];
    
    
    /// style 2
    YNPageConfigration *style_config_2 = [YNPageConfigration defaultConfig];
    style_config_2.showBottomLine = YES;
    style_config_2.bottomLineBgColor = [UIColor greenColor];
    style_config_2.bottomLineHeight = 1;
    
    YNPageScrollMenuView *style_2 = [YNPageScrollMenuView pagescrollMenuViewWithFrame:CGRectMake(0, style_1.yn_bottom + 20, YFScreen.width, 44) titles:@[@"系统偏好设置", @"网易云音乐", @"有道词典", @"微信", @"QQ游戏", @"QQ邮箱", @"数码测色计"].mutableCopy configration:style_config_2 delegate:self currentIndex:0];
    
    /// style 3
    YNPageConfigration *style_config_3 = [YNPageConfigration defaultConfig];
    style_config_3.showBottomLine = YES;
    style_config_3.bottomLineBgColor = [UIColor greenColor];
    style_config_3.bottomLineHeight = 1;
    style_config_3.scrollMenu = NO;
    style_config_3.aligmentModeCenter = NO;
    style_config_3.lineWidthEqualFontWidth = NO;
    style_config_3.showBottomLine = YES;
    style_config_3.itemFont = [UIFont systemFontOfSize:14];
    style_config_3.selectedItemColor = [UIColor redColor];
    style_config_3.normalItemColor = [UIColor blackColor];
    
    YNPageScrollMenuView *style_3 = [YNPageScrollMenuView pagescrollMenuViewWithFrame:CGRectMake(0, style_2.yn_bottom + 20, YFScreen.width, 44) titles:@[@"QQ游戏", @"QQ邮箱", @"数码测色计"].mutableCopy configration:style_config_3 delegate:self currentIndex:0];
    
    
    /// style 4
    YNPageConfigration *style_config_4 = [YNPageConfigration defaultConfig];
    style_config_4.converColor = [UIColor grayColor];
    style_config_4.showConver = YES;
    style_config_4.itemFont = [UIFont systemFontOfSize:14];
    style_config_4.selectedItemColor = [UIColor redColor];
    style_config_4.normalItemColor = [UIColor blackColor];
    style_config_4.itemMaxScale = 1.3;
    
    
    YNPageScrollMenuView *style_4 = [YNPageScrollMenuView pagescrollMenuViewWithFrame:CGRectMake(0, style_3.yn_bottom + 20, YFScreen.width, 44) titles:@[@"QQ游戏", @"QQ邮箱", @"数码测色计"].mutableCopy configration:style_config_4 delegate:self currentIndex:2];
    
    /// style 5
    YNPageConfigration *style_config_5 = [YNPageConfigration defaultConfig];
    style_config_5.selectedItemColor = [UIColor redColor];
    style_config_5.selectedItemFont = [UIFont systemFontOfSize:15];
    
    YNPageScrollMenuView *style_5 = [YNPageScrollMenuView pagescrollMenuViewWithFrame:CGRectMake(0, style_4.yn_bottom + 20, YFScreen.width, 44) titles:@[@"JAVA", @"Object-C", @"JS"].mutableCopy configration:style_config_5 delegate:self currentIndex:1];
    
    /// style 6
    YNPageConfigration *style_config_6 = [YNPageConfigration defaultConfig];
    style_config_6.scrollMenu = YES;
    style_config_6.aligmentModeCenter = NO;
    
    YNPageScrollMenuView *style_6 = [YNPageScrollMenuView pagescrollMenuViewWithFrame:CGRectMake(0, style_5.yn_bottom + 20, YFScreen.width, 44) titles:@[@"JAVA", @"Object-C", @"JS"].mutableCopy configration:style_config_6 delegate:self currentIndex:1];
    
    /// style 7
    YNPageConfigration *style_config_7 = [YNPageConfigration defaultConfig];
    style_config_7.scrollMenu = NO;
    style_config_7.aligmentModeCenter = NO;
    NSMutableArray *buttonArrayM = @[].mutableCopy;
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"small_icon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"icon_back_small_black"] forState:UIControlStateSelected];
        
        /// seTitle -> sizeToFit -> 自行调整位置
        /// button.imageEdgeInsets = UIEdgeInsetsMake(0, 100, 0, 0);
        [buttonArrayM addObject:button];
    }
    style_config_7.buttonArray = buttonArrayM;
    
    
    YNPageScrollMenuView *style_7 = [YNPageScrollMenuView pagescrollMenuViewWithFrame:CGRectMake(0, style_6.yn_bottom + 20, YFScreen.width, 44) titles:@[@"带iCON", @"小图标", @"位置"].mutableCopy configration:style_config_7 delegate:self currentIndex:1];
    
    [_scrollView addSubview:style_1];
    [_scrollView addSubview:style_2];
    [_scrollView addSubview:style_3];
    [_scrollView addSubview:style_4];
    [_scrollView addSubview:style_5];
    [_scrollView addSubview:style_6];
    [_scrollView addSubview:style_7];
    
    [self.view addSubview:_scrollView];
    
}


/// 点击item
- (void)pagescrollMenuViewItemOnClick:(UIButton *)label index:(NSInteger)index {
    NSLog(@"button = %@, index = %ld", label.titleLabel.text, (long)index);
}

/// 点击Add按钮
- (void)pagescrollMenuViewAddButtonAction:(UIButton *)button {
    NSLog(@"button = %@", button.titleLabel.text);

}

@end
