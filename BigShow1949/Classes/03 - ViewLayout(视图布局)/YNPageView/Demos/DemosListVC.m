//
//  DemosListVC.m
//  YNPageViewController
//
//  Created by ZYN on 2018/6/22.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "DemosListVC.h"
#import "YNTestPageVC.h"
#import "YNTopPageVC.h"
#import "YNNavPageVC.h"
#import "YNSuspendCenterPageVC.h"
#import "YNSuspendTopPageVC.h"
#import "YNScrollMenuStyleVC.h"
#import "YNLoadPageVC.h"
#import "YNSuspendTopPausePageVC.h"
#import "YNSuspendCustomNavOrSuspendPositionVC.h"

typedef NS_ENUM(NSInteger, YNVCType) {
    YNVCTypeSuspendCenterPageVC = 1,
    YNVCTypeSuspendTopPageVC = 2,
    YNVCTypeTopPageVC = 3,
    YNVCTypeSuspendTopPausePageVC = 4,
    YNVCTypeSuspendCustomNavOrSuspendPosition = 5,
    YNVCTypeNavPageVC = 6,
    YNVCTypeScrollMenuStyleVC = 7,
    YNVCTypeLoadPageVC = 8,
    YNVCTypeYNTestPageVC = 100
};

@interface DemosListVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArrayM;

@end

@implementation DemosListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Demos";
    [self.view addSubview:self.tableView];

    self.dataArrayM = @[@{@"title" : @"悬浮样式--下拉刷新在中间", @"type" : @(YNVCTypeSuspendCenterPageVC)},
                        @{@"title" : @"悬浮样式--下拉刷新在顶部", @"type" : @(YNVCTypeSuspendTopPageVC)},
                        @{@"title" : @"悬浮样式--下拉刷新在顶部(QQ联系人样式)", @"type" : @(YNVCTypeSuspendTopPausePageVC)},
                        @{@"title" : @"悬浮样式--自定义导航条或自定义悬浮位置", @"type" : @(YNVCTypeSuspendCustomNavOrSuspendPosition)},
                        @{@"title" : @"加载数据后显示页面(隐藏导航条)", @"type" : @(YNVCTypeLoadPageVC)},
                        @{@"title" : @"顶部样式", @"type" : @(YNVCTypeTopPageVC)},
                        @{@"title" : @"导航条样式", @"type" : @(YNVCTypeNavPageVC)},
                        @{@"title" : @"菜单栏样式", @"type" : @(YNVCTypeScrollMenuStyleVC)},
                        @{@"title" : @"测试专用", @"type" : @(YNVCTypeYNTestPageVC)}
                        ].mutableCopy;
}


#pragma mark - UITableViewDelegate  UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArrayM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    NSDictionary *dict = self.dataArrayM[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = self.dataArrayM[indexPath.row];
    NSString *title = dict[@"title"];
    YNVCType type = [dict[@"type"] integerValue];
    UIViewController *vc = nil;
    switch (type) {
        case YNVCTypeSuspendTopPageVC:
        {
            vc = [YNSuspendTopPageVC suspendTopPageVC] ;
        }
            break;
        case YNVCTypeSuspendCenterPageVC:
        {
            vc = [YNSuspendCenterPageVC suspendCenterPageVC];
        }
            break;
        case YNVCTypeSuspendTopPausePageVC:
        {
            vc = [YNSuspendTopPausePageVC suspendTopPausePageVC];
        }
            break;
        case YNVCTypeSuspendCustomNavOrSuspendPosition:
        {
            vc = [YNSuspendCustomNavOrSuspendPositionVC new];
        }
            break;
        case YNVCTypeTopPageVC:
        {
            vc = [YNTopPageVC topPageVC];
        }
            break;
        case YNVCTypeNavPageVC:
        {
            vc = [YNNavPageVC navPageVC];
        }
            break;
        case YNVCTypeLoadPageVC:
        {
            vc = [YNLoadPageVC new];
        }
            break;
        case YNVCTypeScrollMenuStyleVC: {
            vc = [YNScrollMenuStyleVC new];
        }
            break;
        case YNVCTypeYNTestPageVC:
        {
            vc = [YNTestPageVC testPageVC];
        }
            break;
    }
    if (vc) {
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
