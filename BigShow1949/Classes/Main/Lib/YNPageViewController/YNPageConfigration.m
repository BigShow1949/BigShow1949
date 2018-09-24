//
//  YNPageConfigration.m
//  YNPageViewController
//
//  Created by ZYN on 2018/4/22.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "YNPageConfigration.h"
#import "UIView+YNPageExtend.h"

@interface YNPageConfigration ()

@property (nonatomic, strong) NSArray *normalColorArrays;

@property (nonatomic, strong) NSArray *selectedColorArrays;

@property (nonatomic, strong) NSArray *deltaColorArrays;

@end

@implementation YNPageConfigration

- (instancetype)init
{
    self = [super init];
    if (self) {
        _showNavigation = YES;
        _showTabbar = NO;
        _pageStyle = YNPageStyleTop;
        _showConver = NO;
        _showScrollLine = YES;
        _showBottomLine = NO;
        _showGradientColor =YES;
        _showAddButton = NO;
        _scrollMenu = YES;
        _bounces = YES;
        _aligmentModeCenter = YES;
        _lineWidthEqualFontWidth = NO;
        
        _pageScrollEnabled = YES;
        
        _headerViewCouldScale = NO;
        
        _lineColor = [UIColor redColor];
        _converColor = [UIColor groupTableViewBackgroundColor];
        _addButtonBackgroundColor = [UIColor whiteColor];
        _bottomLineBgColor = [UIColor greenColor];
        _scrollViewBackgroundColor = [UIColor whiteColor];
        _normalItemColor = [UIColor grayColor];
        _selectedItemColor = [UIColor greenColor];
        _lineHeight = 2;
        _converHeight = 28;
        
        _menuHeight = 44;
        _menuWidth = kYNPAGE_SCREEN_WIDTH;
        _coverCornerRadius = 14;
        _itemMargin = 15;
        _itemLeftAndRightMargin = 15;
        _itemFont = [UIFont systemFontOfSize:14];
        _selectedItemFont = _itemFont;
        _itemMaxScale = 0;
        _lineBottomMargin = 0;
        _lineLeftAndRightAddWidth = 0;
        
        _bottomLineHeight = 2;
    }
    return self;
}

- (void)setRGBWithProgress:(CGFloat)progress {
    
    _deltaSelR = [self.normalColorArrays[0] floatValue] + [self.deltaColorArrays[0] floatValue] * progress;
    _deltaSelG = [self.normalColorArrays[1] floatValue] + [self.deltaColorArrays[1] floatValue] * progress;
    _deltaSelB = [self.normalColorArrays[2] floatValue] + [self.deltaColorArrays[2] floatValue] * progress;
    
    _deltaNorR = [self.selectedColorArrays[0] floatValue] - [self.deltaColorArrays[0] floatValue] * progress;
    _deltaNorG = [self.selectedColorArrays[1] floatValue] - [self.deltaColorArrays[1] floatValue] * progress;
    _deltaNorB = [self.selectedColorArrays[2] floatValue] - [self.deltaColorArrays[2] floatValue] * progress;
    
}

- (CGFloat)lineHeight {
    
    return _showScrollLine ? _lineHeight : 0;
    
}

- (CGFloat)deltaScale {
    
    return _deltaScale = _itemMaxScale - 1.0;
}

- (NSArray *)getRGBArrayWithColor:(UIColor *)color {
    
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    return @[@(r),@(g),@(b)];
}


- (NSArray *)normalColorArrays {
    
    if (!_normalColorArrays) {
        _normalColorArrays = [self getRGBArrayWithColor:_normalItemColor];
    }
    return _normalColorArrays;
    
}

- (NSArray *)selectedColorArrays {
    
    if (!_selectedColorArrays) {
        _selectedColorArrays = [self getRGBArrayWithColor:self.selectedItemColor];
    }
    return _selectedColorArrays;
    
}

- (NSArray *)deltaColorArrays {
    
    if (!_deltaColorArrays) {
        NSMutableArray *arrayM = [[NSMutableArray alloc]initWithCapacity:self.normalColorArrays.count];
        [self.normalColorArrays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrayM addObject: @([self.selectedColorArrays[idx] floatValue] - [obj floatValue])];
        }];
        
        _deltaColorArrays = [arrayM copy];
    }
    return _deltaColorArrays;
    
}

+ (instancetype)defaultConfig {
    
    return [[self alloc] init];
};

@end
