//
//  EcoMainViewController.m
//  BigShow1949
//
//  Created by apple on 17/8/16.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "EcoMainViewController.h"
#import "EcoRouterTool.h"
#import <WebKit/WebKit.h>
//#import "BaseViewController.h"

@interface EcoMainViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation EcoMainViewController

#pragma mark - lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化UI
    [self initUI];
    //加载html
    [self loadWebView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.wkWebView.navigationDelegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.wkWebView.navigationDelegate = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.wkWebView.navigationDelegate = nil;
    self.wkWebView = nil;
}

#pragma mark - 初始化UI
- (void)initUI
{
    [self.view addSubview:self.wkWebView];
}


- (WKWebView *)wkWebView
{
    if (!_wkWebView)
    {
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    }
    return _wkWebView;
}

#pragma mark - 加载webView
- (void)loadWebView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"router" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"htmlString===%@",htmlString);
    [_wkWebView loadHTMLString:htmlString baseURL:nil];
}

#pragma mark - delegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    WKNavigationActionPolicy policy = WKNavigationActionPolicyAllow;
    NSURL *url = navigationAction.request.URL;
    if (WKNavigationTypeLinkActivated == navigationAction.navigationType&& [url.scheme isEqualToString:@"eco"])
    {
        [self doUrl:url.absoluteString];
        policy = WKNavigationActionPolicyCancel;
    }
    decisionHandler(policy);
}

#pragma mark - 跳转界面
- (void)doUrl:(NSString *)urlString
{
    NSLog(@"urlString +==== %@",urlString);
    [EcoRouterTool openUrl:urlString from:self];
}




@end

