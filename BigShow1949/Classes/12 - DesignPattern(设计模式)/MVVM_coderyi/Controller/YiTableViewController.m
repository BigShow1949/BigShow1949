//
//  TableViewController.m
//  YiRefresh
//
//  Created by coderyi on 15/3/5.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//

#import "YiTableViewController.h"
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"
#import "YiTableViewModel.h"
#import "YiTableViewDataSource.h"
#import "YiTableViewDelegate.h"
@interface YiTableViewController ()
{

    YiRefreshHeader *refreshHeader;
    YiRefreshFooter *refreshFooter;
    NSMutableArray *totalSource;
    YiTableViewModel *tableViewModel;
    UITableView *tableView;
    YiTableViewDataSource *tableViewDataSource;
    YiTableViewDelegate *tableViewDelegate;
}

@end

@implementation YiTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    self.title=@"MVVMDemo With TableView";
    self.view.backgroundColor=[UIColor whiteColor];
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, YFScreen.width, YFScreen.height - 64) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableViewDataSource=[[YiTableViewDataSource alloc] init];
    tableViewDelegate=[[YiTableViewDelegate alloc] init];
    tableView.dataSource=tableViewDataSource;
    tableView.delegate=tableViewDelegate;
    tableViewModel=[[YiTableViewModel alloc] init];
    totalSource=0;
    
//    YiRefreshHeader  头部刷新按钮的使用
    refreshHeader=[[YiRefreshHeader alloc] init];
    refreshHeader.scrollView=tableView;
    [refreshHeader header];
    __weak typeof(self) weakSelf = self;
    refreshHeader.beginRefreshingBlock=^(){
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf headerRefreshAction];
    };
    
//    是否在进入该界面的时候就开始进入刷新状态
    [refreshHeader beginRefreshing];

//    YiRefreshFooter  底部刷新按钮的使用
    refreshFooter=[[YiRefreshFooter alloc] init];
    refreshFooter.scrollView=tableView;
    [refreshFooter footer];
    
    refreshFooter.beginRefreshingBlock=^(){
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf footerRefreshAction];
    };
    
}

- (void)headerRefreshAction
{
   
    [tableViewModel headerRefreshRequestWithCallback:^(NSArray *array){
        totalSource=(NSMutableArray *)array;
        tableViewDataSource.array=totalSource;
        tableViewDelegate.array=totalSource;
        [refreshHeader endRefreshing];
        [tableView reloadData];
    }];

}

- (void)footerRefreshAction
{
    [tableViewModel footerRefreshRequestWithCallback:^(NSArray *array){
        [totalSource addObjectsFromArray:array] ;
        tableViewDataSource.array=totalSource;
        tableViewDelegate.array=totalSource;
        [refreshFooter endRefreshing];
        [tableView reloadData];
    
    }];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
