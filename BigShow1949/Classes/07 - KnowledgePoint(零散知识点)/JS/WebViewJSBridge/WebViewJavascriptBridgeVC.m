//
//  WebViewJavascriptBridgeVC.m
//  BigShow1949
//
//  Created by apple on 17/7/28.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "WebViewJavascriptBridgeVC.h"
//#import "QSWebView1Controller.h"

@interface WebViewJavascriptBridgeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

/* ============  调用第三方 WebViewJavascriptBridge    ==========*/
@implementation WebViewJavascriptBridgeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    self.title = @"QSUseWebViewDemo";
    
    self.dataSource = [NSMutableArray arrayWithObjects:@"基于WebViewJavascriptBridge的深度交互",@"清除缓存", nil];
    [self.view addSubview:self.tableView];
    
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, YFScreen.width, YFScreen.height - 64) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *vc = nil;
    switch (indexPath.section) {
        case 0:
//            vc = [[QSWebView1Controller alloc]init];
            break;
            
        default:
            break;
    }
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //
//        [[SDImageCache sharedImageCache]clearDisk];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
