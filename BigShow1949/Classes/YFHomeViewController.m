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
 
    注意:很多demo没有适配, 很多图片也不全, 本人是用iPhone5来测试的
 
    Github: https://github.com/BigShow1949/BigShow1949
    本人QQ:1029883589 代码有任何问题都可以找我交流
    QQ群:148279151(高手在民间)
    博客:http://www.cnblogs.com/bigshow1949/
 
 *********************************************/

@implementation YFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[@"按钮",
                    @"标签",
                    @"视图布局",
                    @"视图切换",
                    @"视图效果",
                    @"文字视图",
                    @"零散知识点",
                    @"小项目展示",
                    @"动画集合",
                    @"UIKit",
                    @"仿主流app功能",
                    @"设计模式",
                    @"常用工具类",
                    @"数据持久化",
                    @"网络请求",
                    @"博客/论坛",
                    @"算法"];
    
    // 框架模式有哪些？
    //  MVC、MTV、MVP、CBD、ORM等等；
    
    
    self.classNames = @[@"YFButtonViewController",
                        @"YFLabelViewController",
                        @"YFViewLayoutViewController",
                        @"YFViewTransitionViewController",
                        @"YFViewEffectsViewController",
                        @"YFTextViewController",
                        @"YFKnowledgeViewController",
                        @"YFLittleProjectViewController",
                        @"YFAnimationsViewController",
                        @"YFUIKitViewController",
                        @"YFImitateAppViewController",
                        @"YFDesignPatternViewController",
                        @"YFToolsViewController",
                        @"YFDataPersistenceViewController",
                        @"YFNetworkRequestViewController",
                        @"YFBlogViewController",
                        @"YFAlgorithmViewController"];
    
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
