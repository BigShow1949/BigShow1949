//
//  JS_JavaScriptCoreViewController.m
//  BigShow1949
//
//  Created by 杨帆 on 2018/3/24.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

#import "JS_JavaScriptCoreViewController.h"

@interface JS_JavaScriptCoreViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;

@end

@implementation JS_JavaScriptCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //   OC调用JS的三种方式, 具体见80行

    self.title = @"UIWebView-JavaScriptCore";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate = self;
    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"JS_JavaScriptCore.html" withExtension:nil];
    //    NSURL *htmlURL = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
    
    self.webView.backgroundColor = [UIColor clearColor];
    // UIWebView 滚动的比较慢，这里设置为正常速度
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

- (void)dealloc
{
    NSLog(@"dealloc ======== %s",__func__);
}

#pragma mark - private method
- (void)addCustomActions
{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    [context evaluateScript:@"var arr = [3, 4, 'abc'];"];
    
    [self addScanWithContext:context];
    
    [self addLocationWithContext:context];
    
    [self addSetBGColorWithContext:context];
    
    [self addShareWithContext:context];
    
    [self addPayActionWithContext:context];
    
    [self addShakeActionWithContext:context];
    
    [self addGoBackWithContext:context];
}

- (void)addScanWithContext:(JSContext *)context
{
    context[@"scan"] = ^() {
        NSLog(@"扫一扫啦");
    };
}

// 获取位置信息
- (void)addLocationWithContext:(JSContext *)context
{
    context[@"getLocation"] = ^() {
        
        // 将结果返回给js的三种方式 方式1
        NSString *jsStr = [NSString stringWithFormat:@"setLocation('%@')",@"广东省深圳市南山区学府路XXXX号"];
        [[JSContext currentContext] evaluateScript:jsStr];

    };
}

- (void)addShareWithContext:(JSContext *)context
{
    context[@"share"] = ^() {
        NSArray *args = [JSContext currentArguments];
        
        if (args.count < 3) {
            return ;
        }
        
        NSString *title = [args[0] toString];
        NSString *content = [args[1] toString];
        NSString *url = [args[2] toString];
        // 在这里执行分享的操作
        
        // 将分享结果返回给js
        NSString *jsStr = [NSString stringWithFormat:@"shareResult('%@','%@','%@')",title,content,url];
        [[JSContext currentContext] evaluateScript:jsStr];
    };
}

- (void)addSetBGColorWithContext:(JSContext *)context
{
    __weak typeof(self) weakSelf = self;
    context[@"setColor"] = ^() {
        NSArray *args = [JSContext currentArguments];
        
        if (args.count < 4) {
            return ;
        }
        
        CGFloat r = [[args[0] toNumber] floatValue];
        CGFloat g = [[args[1] toNumber] floatValue];
        CGFloat b = [[args[2] toNumber] floatValue];
        CGFloat a = [[args[3] toNumber] floatValue];
        
        weakSelf.view.backgroundColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
    };
}

- (void)addPayActionWithContext:(JSContext *)context
{
    context[@"payAction"] = ^() {
        NSArray *args = [JSContext currentArguments];
        
        if (args.count < 4) {
            return ;
        }
        
        NSString *orderNo = [args[0] toString];
        NSString *channel = [args[1] toString];
        long long amount = [[args[2] toNumber] longLongValue];
        NSString *subject = [args[3] toString];
        
        // 支付操作
        NSLog(@"orderNo:%@---channel:%@---amount:%lld---subject:%@",orderNo,channel,amount,subject);
        
        // 将支付结果返回给js
        //        NSString *jsStr = [NSString stringWithFormat:@"payResult('%@')",@"支付成功"];
        //        [[JSContext currentContext] evaluateScript:jsStr];
        // 将结果返回给js的三种方式 方式2
        [[JSContext currentContext][@"payResult"] callWithArguments:@[@"支付成功"]];
        
        // 方式 3
//        NSString *jsStr = [NSString stringWithFormat:@"payResult('%@')",@"支付成功"];
//        [weakSelf.webView stringByEvaluatingJavaScriptFromString:jsStr];
    };
}

- (void)addShakeActionWithContext:(JSContext *)context
{
    
    context[@"shake"] = ^() {
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    };
}

- (void)addGoBackWithContext:(JSContext *)context
{
    __weak typeof(self) weakSelf = self;
    context[@"goBack"] = ^() {
        [weakSelf.webView goBack];
    };
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    
    [self addCustomActions];
}

@end
