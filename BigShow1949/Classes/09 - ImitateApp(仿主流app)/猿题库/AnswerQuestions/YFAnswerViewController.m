//
//  YFAnswerViewController.m
//  AnswerQuestions
//
//  Created by zhht01 on 16/3/29.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFAnswerViewController.h"
#import "YFAnswerNaviBar.h"


#import "YFResizableView.h"

@interface YFAnswerViewController ()<YFAnswerNaviBarDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) YFAnswerNaviBar *naviBar;

@property (nonatomic, strong) YFResizableView *resizableView;







@end

@implementation YFAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"语文";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    CGFloat w = YFScreen.width;
    CGFloat h = YFScreen.height - self.naviBar.frame.size.height;
    YFResizableView *resizableView = [[YFResizableView alloc] initWithFrame:CGRectMake(0, self.naviBar.frame.size.height, w, h)];
    self.resizableView = resizableView;

    [self.view addSubview:resizableView];

}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;

}




#pragma mark - setter
- (YFAnswerNaviBar *)naviBar {
    
    if (!_naviBar) {
        _naviBar = [[YFAnswerNaviBar alloc] init];
        _naviBar.delegate = self;
        [self.view addSubview:_naviBar];
    }
    return _naviBar;
}

#pragma mark - YFAnswerNaviBarDelegate
- (void)backButtonClick {

    [self.navigationController popViewControllerAnimated:YES];
}




- (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize {
    
    NSDictionary *atts = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:atts context:nil].size;
}


@end
