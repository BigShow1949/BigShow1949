//
//  BasePageViewController.m
//  YNPageViewController
//
//  Created by ZYN on 2018/7/27.
//  Copyright © 2018年 yongneng. All rights reserved.
//  中间层 - 为了演示API功能操作

#import "BasePageViewController.h"
#import "BaseTableViewVC.h"
#import "UIView+YNPageExtend.h"
#import "FTPopOverMenu.h"
@interface BasePageViewController ()

@end

@implementation BasePageViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"功能操作"
                                              style:UIBarButtonItemStylePlain
                                              target:self                 action:@selector(rightButtonOnClick:event:)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
- (void)rightButtonOnClick:(UIBarButtonItem *)item event:(UIEvent *)event {
    __weak typeof(self) weakSelf = self;
    [FTPopOverMenu showFromEvent:event withMenuArray:@[@"滚动到顶部",
                                                       @"更新菜单栏标题",
                                                       @"添加页面",
                                                       @"删除页面",
                                                       @"调整标题顺序",
                                                       @"reload",
                                                       @"刷新头部高度"] doneBlock:^(NSInteger selectedIndex) {
        switch (selectedIndex) {
            case 0:
            {
                [weakSelf scrollToTop:YES];
            }
                break;
            case 1:
            {
//                [self updateMenuItemTitle:@"更新的标题" index:0];
                [weakSelf updateMenuItemTitles:@[@"足球", @"棒球", @"篮球"]];
            }
                break;
            case 2:
            {
                BaseTableViewVC *vc_1 = [[BaseTableViewVC alloc] init];
                vc_1.cellTitle = @"插入页新面";
                [weakSelf insertPageChildControllersWithTitles:@[@"插入页面"] controllers:@[vc_1] index:1];
            }
                break;
            case 3:
            {
//                [self removePageControllerWithTitle:@"帽子"];
                 [weakSelf removePageControllerWithIndex:0];
            }
                break;
            case 4:
            {
                [weakSelf replaceTitlesArrayForSort:@[@"帽子", @"衣服", @"鞋子"]];
            }
                break;
            case 5:
            {
                weakSelf.titlesM = @[@"刷新页面", @"棒球", @"篮球"].mutableCopy;
                weakSelf.config.menuHeight = 100;
                weakSelf.pageIndex = 0;
                [weakSelf reloadData];
            }
                break;
            case 6:
            {
                weakSelf.headerView.yn_height = 300;
                [weakSelf reloadData];
            }
                break;
        }
    } dismissBlock:nil];
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter

@end
