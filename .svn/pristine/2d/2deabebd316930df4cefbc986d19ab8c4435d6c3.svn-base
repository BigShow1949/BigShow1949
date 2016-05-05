//
//  YFAuthorBlogViewController.m
//  appStoreDemo
//
//  Created by WangMengqi on 15/9/2.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

#import "YFAuthorBlogViewController.h"

@interface YFAuthorBlogViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation YFAuthorBlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        [self jumpWebViewWithUrlStr:@"http://www.cnblogs.com/bigshow1949/p/4777815.html"];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

#pragma mark - private
- (void)jumpWebViewWithUrlStr:(NSString *)urlStr {
    
    NSURL *fileURL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    [self.webView loadRequest:request];
}


#pragma mark - 懒加载
- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithObjects:@"01 - App installation failed原因及解决方法", nil];
    }
    return _dataSource;
}

- (UIWebView *)webView {

    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, YFScreen.width, YFScreen.height)];
        _webView = webView;
        [self.view addSubview:webView];
    }
    return _webView;
}


@end
