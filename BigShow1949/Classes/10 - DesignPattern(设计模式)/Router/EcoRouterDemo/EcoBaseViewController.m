//
//  EcoBaseViewController.m
//  BigShow1949
//
//  Created by apple on 17/8/16.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "EcoBaseViewController.h"
#import "UIViewController+Router.h"

@interface EcoBaseViewController ()

@property (nonatomic, strong) UITextView *resultTextView;

@end

@implementation EcoBaseViewController


#pragma mark - lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化UI
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化UI
- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.resultTextView];
    
    [self setNavBarItem];
}


- (UITextView *)resultTextView
{
    if (!_resultTextView) {
        NSInteger padding = 20;
        NSInteger viewWith = self.view.frame.size.width;
        NSInteger viewHeight = self.view.frame.size.height - 64;
        _resultTextView = [[UITextView alloc] initWithFrame:CGRectMake(padding, padding + 64, viewWith - padding * 2, viewHeight - padding * 2)];
        _resultTextView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
        _resultTextView.layer.borderWidth = 1;
        _resultTextView.editable = NO;
        _resultTextView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        _resultTextView.font = [UIFont systemFontOfSize:14];
        _resultTextView.textColor = [UIColor colorWithWhite:0.2 alpha:1];
        _resultTextView.contentOffset = CGPointZero;
        [self appendLog:self.paramDic.description];
    }
    
    return _resultTextView;
}

- (void)appendLog:(NSString *)log
{
    NSString *currentLog = self.resultTextView.text;
    
    
    if (currentLog.length) {
        currentLog = [currentLog stringByAppendingString:[NSString stringWithFormat:@"\n----------\n%@", log]];
    } else {
        currentLog = log;
    }
    self.resultTextView.text = currentLog;
    [self.resultTextView sizeThatFits:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)];
}

///设置导航条
- (void)setNavBarItem
{
    [self addLeftItem];
    [self addRightItem];
}

- (void)addLeftItem
{
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(actionCancel)];
    self.navigationItem.leftBarButtonItem = cancelItem;
}


- (void)addRightItem
{
    UIBarButtonItem *goItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionGo)];
    self.navigationItem.rightBarButtonItem = goItem;
}

#pragma mark - Action
///取消
- (void)actionCancel
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

///跳转
- (void)actionGo
{
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
