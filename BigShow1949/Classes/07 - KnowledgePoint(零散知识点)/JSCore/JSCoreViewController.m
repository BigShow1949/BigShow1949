//
//  JSCoreViewController.m
//  BigShow1949
//
//  Created by apple on 17/6/28.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "JSCoreViewController.h"

// 记得导入JavaScriptCore.framework

@interface JSCoreViewController ()<UIWebViewDelegate>

@end

@implementation JSCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    //创建一个webView来加载html
    _webView = [[UIWebView alloc]init];
    _webView.frame = CGRectMake(0, 0, YFScreen.width, YFScreen.height/2);
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    //先加载一个本地的html
    NSString * path = [[NSBundle mainBundle] pathForResource:@"Test.html" ofType:nil];
    NSURL * url = [[NSURL alloc]initFileURLWithPath:path];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    //创建两个原生button,演示调用js方法
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2, 200, 50);
    btn1.backgroundColor = [UIColor blackColor];
    [btn1 setTitle:@"OC调用无参JS" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(function1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2+100, 200, 50);
    btn2.backgroundColor = [UIColor blackColor];
    [btn2 setTitle:@"OC调用JS(传参)" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(function2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

}

#pragma OC调用JS方法
-(void)function1{
    [_webView stringByEvaluatingJavaScriptFromString:@"aaa()"];
}
-(void)function2{
    NSString * name = @"pheromone";
    NSInteger num = 520;
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"bbb('%@','%ld');",name,num]];
}

#pragma UIWebViewDelegate方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"开始响应请求时触发");
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始加载网页");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"网页加载完毕");
    //获取js的运行环境
    _context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //html调用无参数OC
    _context[@"test1"] = ^(){
        [self menthod1];
    };
    //html调用OC(传参数过来)
    _context[@"test2"] = ^(){
        NSArray * args = [JSContext currentArguments];//传过来的参数
        //        for (id  obj in args) {
        //            NSLog(@"html传过来的参数%@",obj);
        //        }
        NSString * name = args[0];
        NSString * str = args[1];
        [self menthod2:name and:str];
    };
    
    
    //OC调用JS方法
    //1.直接调用
    NSString *alertJS=@"alert('test js OC')"; //准备执行的js代码
    [_context evaluateScript:alertJS];
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"网页加载出错");
}


#pragma JS调用OC的方法 
/*
    上线时背景色是白色的, 可能上线后又觉得蓝色更好看,我们可以用html(demo里的html是项目里的)
    如果html后台获取,这个时候可以用js来控制背景色, 不用再打包就能修改项目
 */
-(void)menthod1{
    NSLog(@"JS调用了无参数OC方法, 改变了背景色"); 
    self.view.backgroundColor = [UIColor blueColor];
}
-(void)menthod2:(NSString *)str1 and:(NSString *)str2{
    NSLog(@"%@%@",str1,str2);
    self.view.backgroundColor = [UIColor redColor];
}



@end
