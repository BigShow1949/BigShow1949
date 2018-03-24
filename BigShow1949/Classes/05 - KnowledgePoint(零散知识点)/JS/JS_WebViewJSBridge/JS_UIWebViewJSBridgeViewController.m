//
//  JS_UIWebViewJSBridgeViewController.m
//  BigShow1949
//
//  Created by 杨帆 on 2018/3/24.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "WebViewJavascriptBridge.h"

#import "JS_UIWebViewJSBridgeViewController.h"

@interface JS_UIWebViewJSBridgeViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@property WebViewJavascriptBridge *webViewBridge;

@end

@implementation JS_UIWebViewJSBridgeViewController

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UIWebView--WebViewJavascriptBridgeL";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(rightClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    
    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
    
    // UIWebView 滚动的比较慢，这里设置为正常速度
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self.webView loadRequest:request];
    
    _webViewBridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [_webViewBridge setWebViewDelegate:self];
    
    // 添加JS 要调用的Native 功能
    [self registerNativeFunctions];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

- (void)rightClick
{
    //    // 如果不需要参数，不需要回调，使用这个
    //    [_webViewBridge callHandler:@"testJSFunction"];
    //    // 如果需要参数，不需要回调，使用这个
    //    [_webViewBridge callHandler:@"testJSFunction" data:@"一个字符串"];
    // 如果既需要参数，又需要回调，使用这个
    [_webViewBridge callHandler:@"testJSFunction" data:@"一个字符串" responseCallback:^(id responseData) {
        NSLog(@"调用完JS后的回调：%@",responseData);
    }];
}

#pragma mark - private method
- (void)registerNativeFunctions
{
    [self registScanFunction];
    
    [self registShareFunction];
    
    [self registLocationFunction];
    
    [self regitstBGColorFunction];
    
    [self registPayFunction];
    
    [self registShakeFunction];
}

- (void)registLocationFunction
{
    [_webViewBridge registerHandler:@"locationClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // 获取位置信息
        
        NSString *location = @"广东省深圳市南山区学府路XXXX号";
        // 将结果返回给js
        responseCallback(location);
    }];
}

- (void)registScanFunction
{
    // 注册的handler 是供 JS调用Native 使用的。
    [_webViewBridge registerHandler:@"scanClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"扫一扫");
        NSString *scanResult = @"http://www.baidu.com";
        responseCallback(scanResult);
    }];
}

- (void)registShareFunction
{
    [_webViewBridge registerHandler:@"shareClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        NSDictionary *tempDic = data;
        // 在这里执行分享的操作
        NSString *title = [tempDic objectForKey:@"title"];
        NSString *content = [tempDic objectForKey:@"content"];
        NSString *url = [tempDic objectForKey:@"url"];
        
        // 将分享的结果返回到JS中
        NSString *result = [NSString stringWithFormat:@"分享成功:%@,%@,%@",title,content,url];
        responseCallback(result);
    }];
}

- (void)regitstBGColorFunction
{
    __weak typeof(self) weakSelf = self;
    [_webViewBridge registerHandler:@"colorClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        NSDictionary *tempDic = data;
        
        CGFloat r = [[tempDic objectForKey:@"r"] floatValue];
        CGFloat g = [[tempDic objectForKey:@"g"] floatValue];
        CGFloat b = [[tempDic objectForKey:@"b"] floatValue];
        CGFloat a = [[tempDic objectForKey:@"a"] floatValue];
        
        weakSelf.webView.backgroundColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
    }];
}

- (void)registPayFunction
{
    [_webViewBridge registerHandler:@"payClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        NSDictionary *tempDic = data;
        
        NSString *orderNo = [tempDic objectForKey:@"order_no"];
        long long amount = [[tempDic objectForKey:@"amount"] longLongValue];
        NSString *subject = [tempDic objectForKey:@"subject"];
        NSString *channel = [tempDic objectForKey:@"channel"];
        // 支付操作...
        
        // 将分享的结果返回到JS中
        NSString *result = [NSString stringWithFormat:@"支付成功:%@,%@,%@",orderNo,subject,channel];
        responseCallback(result);
    }];
}

- (void)registShakeFunction
{
    [_webViewBridge registerHandler:@"shakeClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    }];
}

- (void)registGoBackFunction
{
    __weak typeof(self) weakSelf = self;
    [_webViewBridge registerHandler:@"goback" handler:^(id data, WVJBResponseCallback responseCallback) {
        [weakSelf.webView goBack];
    }];
}
//*/
@end
