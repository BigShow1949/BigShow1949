//
//  ArtDefaultViewController.m
//  Demo
//
//  Created by weijingyun on 16/10/21.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtDefaultViewController.h"
#import "JYPagingView.h"
#import "ArtTableViewController.h"

@interface ArtDefaultViewController ()<HHHorizontalPagingViewDelegate>

@property (nonatomic, strong) HHHorizontalPagingView *pagingView;
@property (nonatomic, strong) NSLayoutConstraint *topConstraint;

@end

@implementation ArtDefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 改属性设置相当重要
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:242./255. green:242./255. blue:242./255. alpha:1.0];
    [self.pagingView reload];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showText:(NSString *)str{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate: self  cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    });
}

#pragma mark -  HHHorizontalPagingViewDelegate
// 下方左右滑UIScrollView设置
- (NSInteger)numberOfSectionsInPagingView:(HHHorizontalPagingView *)pagingView{
    return 5;
}

- (UIScrollView *)pagingView:(HHHorizontalPagingView *)pagingView viewAtIndex:(NSInteger)index{
    ArtTableViewController *vc = [[ArtTableViewController alloc] init];
    [self addChildViewController:vc];
    vc.index = index;
    vc.fillHight = self.pagingView.segmentTopSpace + 36;
    return (UIScrollView *)vc.view;
}

//headerView 设置
- (CGFloat)headerHeightInPagingView:(HHHorizontalPagingView *)pagingView{
    return 250;
}

- (UIView *)headerViewInPagingView:(HHHorizontalPagingView *)pagingView{
    
    __weak typeof(self)weakSelf = self;
    UIView *headerView = [[UIView alloc] init];
    UIImage *image = [UIImage imageNamed:@"headerImage"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [headerView addSubview:imageView];
    
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.topConstraint = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:headerView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [headerView addConstraint:self.topConstraint];
    [headerView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:headerView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [headerView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:headerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [headerView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:headerView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    headerView.backgroundColor = [UIColor orangeColor];
    [headerView whenTapped:^{
        [weakSelf showText:@"headerView click"];
    }];
    
    UIView *view = [[UIView alloc] init];
    [headerView addSubview:view];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(0, 0, 100, 200);
    view.tag = 1000;
    
    [view whenTapped:^{
        [weakSelf showText:@"redView click"];
    }];
    
    UIView *view1 = [[UIView alloc] init];
    [view addSubview:view1];
    view1.tag = 1001;
    view1.backgroundColor = [UIColor grayColor];
    view1.frame = CGRectMake(50, 50, 50, 100);
    
    
    [view1 whenTapped:^{
        [weakSelf showText:@"grayView click"];
    }];
    
    self.topConstraint.constant = - self.pagingView.pullOffset;
    return headerView;
}

//segmentButtons
- (CGFloat)segmentHeightInPagingView:(HHHorizontalPagingView *)pagingView{
    return 36.;
}

- (NSArray<UIButton*> *)segmentButtonsInPagingView:(HHHorizontalPagingView *)pagingView{
    
    NSMutableArray *buttonArray = [NSMutableArray array];
    for(int i = 0; i < 6; i++) {
        UIButton *segmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [segmentButton setBackgroundImage:[UIImage imageNamed:@"Home_title_line"] forState:UIControlStateNormal];
        [segmentButton setBackgroundImage:[UIImage imageNamed:@"Home_title_line_select"] forState:UIControlStateSelected];
        NSString *str = i == 5 ? @"返回" : [NSString stringWithFormat:@"view%@",@(i)];
        [segmentButton setTitle:str forState:UIControlStateNormal];
        [segmentButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        segmentButton.adjustsImageWhenHighlighted = NO;
        [buttonArray addObject:segmentButton];
    }
    return [buttonArray copy];
}

// 点击segment
- (void)pagingView:(HHHorizontalPagingView*)pagingView segmentDidSelected:(UIButton *)item atIndex:(NSInteger)selectedIndex{
    NSLog(@"%s",__func__);
    if (selectedIndex == 5) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)pagingView:(HHHorizontalPagingView*)pagingView segmentDidSelectedSameItem:(UIButton *)item atIndex:(NSInteger)selectedIndex{
    NSLog(@"%s",__func__);
   
}

// 视图切换完成时调用
- (void)pagingView:(HHHorizontalPagingView*)pagingView didSwitchIndex:(NSInteger)aIndex to:(NSInteger)toIndex{
    NSLog(@"%s \n %tu  to  %tu",__func__,aIndex,toIndex);
}

/*
 与 magnifyTopConstraint 属性相对应  下拉时如需要放大，则传入的图片的上边距约束
 考虑到开发中很少使用原生约束，故放开代理方法 用于用户自行根据 偏移处理相应效果
 如果设置了 magnifyTopConstraint 改方法将不会被调用
 
 */
- (void)pagingView:(HHHorizontalPagingView*)pagingView scrollTopOffset:(CGFloat)offset{
//        NSLog(@"偏移%f",offset);
    if (offset > 0) {
        return;
    }
    self.topConstraint.constant = offset;
}

#pragma mark - 懒加载
- (HHHorizontalPagingView *)pagingView{
    if (!_pagingView) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        _pagingView = [[HHHorizontalPagingView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height) delegate:self];
        _pagingView.segmentTopSpace = 20;
        _pagingView.isGesturesSimulate = YES;
        _pagingView.segmentView.backgroundColor = [UIColor colorWithRed:242./255. green:242./255. blue:242./255. alpha:1.0];
        //        _pagingView.maxCacheCout = 5.;
        [self.view addSubview:_pagingView];
    }
    return _pagingView;
}

@end
