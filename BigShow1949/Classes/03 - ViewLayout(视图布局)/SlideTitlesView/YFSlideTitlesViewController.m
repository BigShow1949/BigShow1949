//
//  YFSlideTitlesViewController.m
//  WSFSlideTitlesView
//
//  Created by WangShengFeng on 3/7/16.
//  Copyright © 2016年 WangShengFeng. All rights reserved.
//

#import "YFSlideTitlesViewController.h"

#import "WSFSlideTitlesView.h"

@interface YFSlideTitlesViewController () <WSFSlideTitlesViewDelegate>

@property (nonatomic, weak) WSFSlideTitlesView *titlesView;

@end

@implementation YFSlideTitlesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // 创建 WSFSlideTitlesView
    [self createWSFSlideTitlesView];
    
    // 临时创建一个按钮修改选中按钮
    [self createSelectButton];
}

- (void)createWSFSlideTitlesView
{
    // 创建设置，最少需要内容和尺寸
    // 其他样式自定义可查看 setting 头文件
    WSFSlideTitlesViewSetting *titlesSetting = [[WSFSlideTitlesViewSetting alloc] init];
    titlesSetting.titlesArr = @[ @"首页", @"消息", @"发现", @"我", ];
    titlesSetting.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 30);
    
    // 通过设置创建 WSFSlideTitlesView
    WSFSlideTitlesView *titlesView = [[WSFSlideTitlesView alloc] initWithSetting:titlesSetting];
    titlesView.delegate = self;
    self.titlesView = titlesView;
    [self.view addSubview:titlesView];
}

- (void)createSelectButton
{
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [selectButton setTitle:@"点击 跳转第0个按钮" forState:UIControlStateNormal];
    [selectButton addTarget:self action:@selector(selectButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [selectButton sizeToFit];
    selectButton.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    
    [self.view addSubview:selectButton];
}

- (void)selectButtonClick
{
    // 在外部控制内部选中按钮，传入 index 即可
    [self.titlesView selectButtonAtIndex:0];
}

#pragma mark - WSFSlideTitlesViewDelegate
- (void)slideTitlesView:(WSFSlideTitlesView *)titlesView didSelectButton:(UIButton *)button atIndex:(NSUInteger)index
{
    // 选中按钮切换通知外部
    NSLog(@"点击 -第%zd个- -%@- 按钮", index, [button attributedTitleForState:UIControlStateNormal].string);
}




@end


