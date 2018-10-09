//
//  YNPageTestViewController.m
//  BigShow1949
//
//  Created by big show on 2018/9/24.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YNPageViewDemoController.h"

#import "YNSuspendTopPageVC.h"
#import "YNSuspendCenterPageVC.h"
#import "YNSuspendTopPausePageVC.h"
#import "YNSuspendCustomNavOrSuspendPositionVC.h"
#import "YNTopPageVC.h"
#import "YNNavPageVC.h"
#import "YNLoadPageVC.h"
#import "YNScrollMenuStyleVC.h"
#import "YNTestPageVC.h"

@interface YNPageViewDemoController ()

@end

@implementation YNPageViewDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupDataArr:@[@[@"悬浮样式--下拉刷新在中间",@"YNVCTypeSuspendCenterPageVC"], // 数据显示不出来
                         @[@"悬浮样式--下拉刷新在顶部",@"YNVCTypeSuspendTopPageVC"],
                         @[@"悬浮样式--下拉刷新在顶部(QQ联系人样式)",@"YNVCTypeSuspendTopPausePageVC"],
                         @[@"悬浮样式--自定义导航条或自定义悬浮位置",@"YNVCTypeSuspendCustomNavOrSuspendPosition"],// 需要加个返回按钮
                         @[@"加载数据后显示页面(隐藏导航条)",@"YNVCTypeLoadPageVC"],
                         @[@"顶部样式",@"YNVCTypeTopPageVC"],
                         @[@"导航条样式",@"YNVCTypeNavPageVC"],// 需要加个返回按钮
                         @[@"菜单栏样式",@"YNVCTypeScrollMenuStyleVC"],
                         @[@"测试专用",@"YNVCTypeYNTestPageVC"],
                         ]];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = nil;
    switch (indexPath.row) {
        case 0:
            vc = [YNSuspendTopPageVC suspendTopPageVC];
            break;
        case 1:
            vc = [YNSuspendCenterPageVC suspendCenterPageVC];
            break;
        case 2:
            vc = [YNSuspendTopPausePageVC suspendTopPausePageVC];
            break;
        case 3:
            vc = [YNSuspendCustomNavOrSuspendPositionVC new];
            break;
        case 4:
            vc = [YNTopPageVC topPageVC];
            break;
        case 5:
            vc = [YNNavPageVC navPageVC];
            break;
        case 6:
            vc = [YNLoadPageVC new];
            break;
        case 7:
            vc = [YNScrollMenuStyleVC new];
            break;
        case 8:
            vc = [YNTestPageVC testPageVC];
            break;
        case 9:
            
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
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
