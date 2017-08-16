//
//  YFBottomEditView.m
//  SmartingPark
//
//  Created by WangMengqi on 15/8/26.
//  Copyright (c) 2015年 智慧停车. All rights reserved.
//

#define YFScreen [UIScreen mainScreen].bounds.size
#import "YFBottomEditView.h"


@interface YFBottomEditView ()<UIAlertViewDelegate>

@property (nonatomic, weak) UIView *bottomView;

@end


@implementation YFBottomEditView

- (void)show {
    [self showWithAnimated:YES];
}

- (void)hidden {
    [self hiddenWithAnimated:YES];
}

- (void)showWithAnimated:(BOOL)animated {
   
    NSTimeInterval animatedTime = animated ? 0.5 : 0.0;
    [UIView animateWithDuration:animatedTime animations:^{
        CGRect tempFrame = self.bottomView.frame;
        tempFrame.origin.y = YFScreen.height - 44;
        self.bottomView.frame = tempFrame;
    }];
}

- (void)hiddenWithAnimated:(BOOL)animated {
    
    NSTimeInterval animatedTime = animated ? 0.5 : 0.0;
    [UIView animateWithDuration:animatedTime animations:^{
        CGRect tempFrame = self.bottomView.frame;
        tempFrame.origin.y = YFScreen.height;
        self.bottomView.frame = tempFrame;
    }completion:^(BOOL finished) {
//        [self.bottomView removeFromSuperview];
    }];
}


#pragma mark - 懒加载
- (UIView *)bottomView {
    

    if (!_bottomView) {
        
        // 背景bottomView
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, YFScreen.height, YFScreen.width, 60)];
        bottomView.backgroundColor = [UIColor whiteColor];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:bottomView];
        _bottomView = bottomView;
        
        
        // 删除按钮
        UIButton *delete = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, bottomView.frame.size.width, bottomView.frame.size.height)];
        self.deleteBtn = delete;
        [delete setTitle:@"删除" forState:UIControlStateNormal];
        [delete setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [delete setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [delete addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        delete.titleLabel.font = [UIFont systemFontOfSize:18];
        // 默认不可点击
        self.deleteBtn.enabled = NO;
        [bottomView addSubview:delete];
        
    }
    return _bottomView;
    
}




- (void)setBackgroundColor:(UIColor *)backgroundColor {

    self.bottomView.backgroundColor = backgroundColor;
}


#pragma mark - private method

- (void)deleteBtnClick:(UIButton *)btn {
    if ([self.dataSource respondsToSelector:@selector(deleteSelectItem)]) {
        [self.dataSource deleteSelectItem];
    }

}

@end
