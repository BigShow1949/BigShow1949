//
//  ArtDefaultViewController.m
//  Demo
//
//  Created by weijingyun on 16/10/21.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import "ArtScrollHeaderViewController.h"
#import "JYPagingView.h"
#import "ArtTableViewController.h"

@interface ArtScrollHeaderViewController ()<HHHorizontalPagingViewDelegate>

@property (nonatomic, strong) HHHorizontalPagingView *pagingView;

@end

@implementation ArtScrollHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
//     Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:242./255. green:242./255. blue:242./255. alpha:1.0];
    [self.pagingView reload];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor purpleColor];
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    but1.frame = CGRectMake(0, 0, 100, 200);
    [but1 addTarget:self action:@selector(but1Click) forControlEvents:UIControlEventTouchUpInside];
    but1.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:but1];
    
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    but2.frame = CGRectMake(800, 0, 100, 200);
    [but2 addTarget:self action:@selector(but2Click) forControlEvents:UIControlEventTouchUpInside];
    but2.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:but2];
    
    scrollView.contentSize = CGSizeMake(1000, 250);
    scrollView.frame = CGRectMake(0, 0, 480, 250);
//    UIView *headerView = [[UIView alloc] init];
//    [headerView addSubview:scrollView];
    return scrollView;
}

- (void)but1Click{
    NSLog(@"%s",__func__);
    [self showText:@"but1Click"];
}

- (void)but2Click{
    NSLog(@"%s",__func__);
    [self showText:@"but2Click"];
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

#pragma mark - 懒加载
- (HHHorizontalPagingView *)pagingView{
    if (!_pagingView) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        _pagingView = [[HHHorizontalPagingView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height) delegate:self];
        _pagingView.segmentTopSpace = 20;
        _pagingView.segmentView.backgroundColor = [UIColor colorWithRed:242./255. green:242./255. blue:242./255. alpha:1.0];
        _pagingView.maxCacheCout = 5.;
        _pagingView.isGesturesSimulate = YES;
        [self.view addSubview:_pagingView];
    }
    return _pagingView;
}

@end
