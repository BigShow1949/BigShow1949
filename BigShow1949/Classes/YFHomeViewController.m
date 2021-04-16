//
//  YFHomeViewController.m
//  BigShow1949
//
//  Created by WangMengqi on 15/9/1.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//
//

#import "YFHomeViewController.h"
#import "YFAuthorViewController.h"


/*******************************************
 
    注意:很多没有适配, 很多图片也不全, 本人是用iPhone5来测试的
 
    Github: https://github.com/BigShow1949/BigShow1949
    博客:http://www.cnblogs.com/bigshow1949/
 
 *********************************************/

@implementation YFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    // 框架模式有哪些？
//    //  MVC、MTV、MVP、CBD、ORM等等；
    
    [self setupDataArr:@[@[@"按钮",@"YFButtonViewController"],
                         @[@"标签",@"YFLabelViewController"],
                         @[@"视图布局",@"YFViewLayoutViewController"],
                         @[@"视图切换",@"YFViewTransitionViewController"],
                         @[@"零散知识点",@"YFKnowledgeViewController"],
                         @[@"小项目展示",@"YFLittleProjectViewController"],
                         @[@"动画集合",@"YFAnimationsViewController"],
                         @[@"UIKit",@"YFUIKitViewController"],
                         @[@"仿主流app功能",@"YFImitateAppViewController"],
                         @[@"设计模式",@"YFDesignPatternViewController"],
                         @[@"常用工具类",@"YFToolsViewController"],
                         @[@"数据持久化",@"YFDataPersistenceViewController"],
                         @[@"网络请求",@"YFNetworkRequestViewController"],
                         @[@"博客/论坛",@"YFBlogViewController"],
                         @[@"算法",@"YFAlgorithmViewController"],
                         @[@"swift专栏",@"SwiftViewController"],]];
    [self setupNav];

}



#pragma mark - private
- (void)setupNav {

    self.title = @"目 录";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"作 者" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
}

- (void)rightBarClick {
    
    YFAuthorViewController *aboutUs = [[YFAuthorViewController alloc] init];
    [self.navigationController pushViewController:aboutUs animated:YES];
}


@end
