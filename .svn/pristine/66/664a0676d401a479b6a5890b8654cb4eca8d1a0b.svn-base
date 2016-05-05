//
//  Case2ViewController.m
//  MasonryExample
//
//  Created by zorro on 15/5/23.
//  Copyright (c) 2015年 tutuge. All rights reserved.
//

#import "Case2ViewController.h"
#import "Masonry.h"

static const CGFloat IMAGE_SIZE = 32;

@interface Case2ViewController ()
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) NSMutableArray *imageViews;
@property (strong, nonatomic) NSMutableArray *widthConstraints;
@property (strong, nonatomic) NSArray *imageNames;

@end

@implementation Case2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageViews = [NSMutableArray new];
    _widthConstraints = [NSMutableArray new];
    _imageNames = @[@"bluefaces_1", @"bluefaces_2", @"bluefaces_3", @"bluefaces_4"];

    [self initContainerView];
    [self initViews];
}

#pragma mark - Actions

- (IBAction)showOrHideImage:(UISwitch *)sender {
    NSUInteger index = (NSUInteger) sender.tag;
    MASConstraint *width = _widthConstraints[index];

    if (sender.on) {
        width.equalTo(@(IMAGE_SIZE));
    } else {
        width.equalTo(@0);
    }
}

#pragma mark - Private methods

- (void)initContainerView {
    _containerView = [UIView new];
    [self.view addSubview:_containerView];

    _containerView.backgroundColor = [UIColor grayColor];

    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        //只设置高度，宽度由子View决定
        make.height.equalTo(@(IMAGE_SIZE));
        //水平居中
        make.centerX.equalTo(self.view.mas_centerX);
        //距离父View顶部200点
        make.top.equalTo(self.view.mas_top).offset(200);
    }];
}

- (void)initViews {
    //循环创建、添加imageView
    for (NSUInteger i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageNames[i]]];
        [_imageViews addObject:imageView];
        [_containerView addSubview:imageView];
    }

    //设定大小
    CGSize imageViewSize = CGSizeMake(IMAGE_SIZE, IMAGE_SIZE);

    //分别设置每个imageView的宽高、左边、垂直中心约束，注意约束的对象
    //每个View的左边约束和左边的View的右边相等=。=，有点绕口...
    
    UIView __block *lastView = nil;
    MASConstraint __block *widthConstraint = nil;
    NSUInteger arrayCount = _imageViews.count;
    [_imageViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            //宽高固定
            widthConstraint = make.width.equalTo(@(imageViewSize.width));
            make.height.equalTo(@(imageViewSize.height));
            //左边约束
            make.left.equalTo(lastView ? lastView.mas_right : view.superview.mas_left);
            //垂直中心对齐
            make.centerY.equalTo(view.superview.mas_centerY);
            //设置最右边的imageView的右边与父view的最有对齐
            if (idx == arrayCount - 1) {
                make.right.equalTo(view.superview.mas_right);
            }
            
            [_widthConstraints addObject:widthConstraint];
            lastView = view;
        }];
    }];
}

@end
