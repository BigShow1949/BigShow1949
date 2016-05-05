//
//  Case3ViewController.m
//  MasonryExample
//
//  Created by zorro on 15/5/23.
//  Copyright (c) 2015年 tutuge. All rights reserved.
//

#import "Case3ViewController.h"
#import "Masonry.h"

@interface Case3ViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewWidthConstraint;
@property (assign, nonatomic) CGFloat maxWidth;
@end

@implementation Case3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    //保存最大宽度
    _maxWidth = _containerViewWidthConstraint.constant;
}

# pragma mark - Actions

- (IBAction)modifyContainerViewWidth:(UISlider *)sender {
    if (sender.value) {
        //改变containerView的宽度
        _containerViewWidthConstraint.constant = sender.value * _maxWidth;
    }
}

# pragma mark - Private methods

- (void) initView {
    UIView *subView = [UIView new];
    subView.backgroundColor = [UIColor redColor];
    
    [_containerView addSubview:subView];
    
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        //上下左贴边
        make.left.equalTo(_containerView.mas_left);
        make.top.equalTo(_containerView.mas_top);
        make.bottom.equalTo(_containerView.mas_bottom);
        
        //宽度为父view的宽度的一半
        make.width.equalTo(_containerView.mas_width).multipliedBy(0.5);
    }];
}

@end
