//
//  Case5ViewController.m
//  MasonryExample
//
//  Created by zorro on 15/8/2.
//  Copyright (c) 2015年 tutuge. All rights reserved.
//

#import "Case5ViewController.h"
#import "Masonry.h"

// 注释掉这个宏定义，就直接使用length值做约束，否则的话，使用新的mas_topLayoutGuide和mas_bottomLayoutGuide
#define NEW_FEATURE

@interface Case5ViewController ()
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *bottomView;
@end

@implementation Case5ViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"top(bottom)LayoutGuide";

    [self initView];
    
    NSLog(@"[viewDidLoad] top: %g", self.topLayoutGuide.length);
}

#pragma mark - Actions

- (IBAction)showOrHideTopBar:(id)sender {
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:NO];
    // 隐藏、显示了NavigationBar以后，要手动触发updateViewConstraints，更新约束
    [self updateViewConstraints];
}

- (IBAction)showOrHideBottomBar:(id)sender {
    [self.navigationController setToolbarHidden:!self.navigationController.toolbarHidden animated:NO];
    // 手动触发updateViewConstraints
    [self updateViewConstraints];
}

- (IBAction)back:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private methods

- (void)initView {
    _topView = [UIView new];
    _topView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.and.right.equalTo(self.view);
        
#ifdef NEW_FEATURE
        make.top.equalTo(self.mas_topLayoutGuide);
#endif
        
    }];

    _bottomView = [UIView new];
    _bottomView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.and.right.equalTo(self.view);
        
#ifdef NEW_FEATURE
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
#endif
    }];
}

#pragma mark - Override

- (void)updateViewConstraints {
    
#ifndef NEW_FEATURE
    // 根据新的length值更新约束
    [_topView mas_updateConstraints:^(MASConstraintMaker *make) {
        // 直接利用其length属性，避免iOS、SDK版本升级后topLayoutGuide不再是UIView
        make.top.equalTo(self.view.mas_top).with.offset(self.topLayoutGuide.length);
    }];

    // 根据新的length值更新约束
    [_bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        // 直接利用其length属性，避免iOS、SDK版本升级后topLayoutGuide不再是UIView
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-(self.bottomLayoutGuide.length));
    }];
#endif
    
    [super updateViewConstraints];
}

@end
