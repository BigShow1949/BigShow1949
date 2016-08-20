//
//  YFSearchController.m
//  BigShow1949
//
//  Created by zhht01 on 16/1/15.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFSearchController.h"
#import "SearchResultsViewController.h"


@interface YFSearchController ()<UISearchResultsUpdating>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation YFSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UISearchController";
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    NSArray *array = @[@"1FUGC", @"2U6GC", @"3U7GC", @"4GFD", @"5DSAY", @"6ASD", @"7QWE", @"8RTY", @"9PDF", @"10MNB", @"VCXZ", @"LKJH"];
    self.dataArray = [NSMutableArray arrayWithArray:array];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchResultsUpdater = self;
}

- (UISearchController *)searchController
{
    if (!_searchController) {
        SearchResultsViewController *searchResultsViewController = [[SearchResultsViewController alloc] init];
        _searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsViewController]; // 传入nil表示使用当前控制器
        _searchController.searchBar.frame = CGRectMake(0, 0, 200, 44);
        _searchController.searchBar.placeholder = @"请输入搜索内容";
    }
    return _searchController;
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // 创建临时数组，存放搜索到的内容
    NSMutableArray *tempArray = [NSMutableArray array];
    NSString *text = searchController.searchBar.text;
    for (NSString *item in self.dataArray) {
        if (text.length != 0 && [item containsString:text]) {
            [tempArray addObject:item];
        }
    }
    
    // 给searchResultViewController进行传值，并且reloadData
    SearchResultsViewController *searchResultsViewController = (SearchResultsViewController *)searchController.searchResultsController;
    searchResultsViewController.tableView.frame = CGRectMake(0, 64, YFScreen.width, YFScreen.height - 64);
    searchResultsViewController.searchDataArray = [NSMutableArray arrayWithArray:tempArray];
    [searchResultsViewController.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}



@end
