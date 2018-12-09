//
//  YFLoginViperViewController.m
//  BigShow1949
//
//  Created by big show on 2018/10/16.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFNoteListViperViewController.h"
#import "YFTNoteListModuleBuilder.h"
#import "YFNoteListViewController.h"
#import "YFNoteDataManager.h"
#import "YFRouter.h"
#import "YFNoteListRouter.h"

@interface YFNoteListViperViewController ()

@end

@implementation YFNoteListViperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /*
     感谢zuik大神分享的博客：https://www.jianshu.com/p/de96a056b66a
     */
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIButton *redBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 44)];
    [redBtn setTitle:@"Button" forState:UIControlStateNormal];
    [redBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    redBtn.titleLabel.textColor = [UIColor blackColor];
    redBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:redBtn];
}

- (void)buttonClick {
    YFNoteListViewController<YFViperViewPrivate> *noteListVC = [[YFNoteListViewController alloc] init];
    id<YFNoteListRouter>router = (id)[[YFRouter alloc] init];
    [YFTNoteListModuleBuilder buildView:noteListVC noteListDataService:[YFNoteDataManager sharedInsatnce] router:router];
    [self.navigationController pushViewController:noteListVC animated:YES];
}

























@end
