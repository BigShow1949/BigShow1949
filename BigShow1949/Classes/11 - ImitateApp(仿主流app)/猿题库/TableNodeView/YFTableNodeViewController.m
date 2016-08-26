//
//  ViewController.m
//  YFTableNodeView
//
//  Created by zhht01 on 16/3/28.
//  Copyright © 2016年 BigShow1949. All rights reserved.
//

#import "YFTableNodeViewController.h"
#import "YFNode.h"

@interface YFTableNodeViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSInteger _count;  // 记录节点在数组中的位置
}
@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) NSMutableArray *dataArray; //保存全部数据
@property (nonatomic, strong) NSMutableArray *displayArray; //保存要显示在界面上的数据的数组



@end

@implementation YFTableNodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.displayArray = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];

    // 添加数据
    [self loadData];
    [self reloadDataForDisplayArray];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
}

- (void)loadData {
    
    /*  点击cell 的时候, 遍历self.dataArray 的时候,title打印崩溃  // 注意plist的路径
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"node.plist" ofType:nil]];
    
    for (NSDictionary *dict in dictArray) {
        YFNode *node = [YFNode nodeWithDict:dict];
        [self.dataArray addObject:node];
    }
//    NSLog(@"friends.plist = %@", dictArray);
    
    NSLog(@"dataArray = %@", self.dataArray);
    
    for (YFNode *node in self.dataArray) {
        NSLog(@"node.title = %@", node.title);
        for (YFNode *sonNode in node.sonNodes) {
            NSLog(@"sonNode.title = %@", sonNode.title);
        }
    }
    // */
    
    //*
    YFNode *node0 = [[YFNode alloc] init];
    node0.isExpanded = NO;
    node0.title = @"数学";
    
    YFNode *node1 = [[YFNode alloc] init];
    node1.isExpanded = NO;
    node1.title = @"英语";
    
    YFNode *node2 = [[YFNode alloc] init];
    node2.isExpanded = NO;
    node2.title = @"中学数学";
    
    YFNode *node3 = [[YFNode alloc] init];
    node3.isExpanded = NO;
    node3.title = @"高中数学";
    
    YFNode *node4 = [[YFNode alloc] init];
    node4.isExpanded = NO;
    node4.title = @"二次方程";
    
    YFNode *node5 = [[YFNode alloc] init];
    node5.isExpanded = NO;
    node5.title = @"集合与函数";
    
    YFNode *node6 = [[YFNode alloc] init];
    node6.isExpanded = NO;
    node6.title = @"数列";
    
    YFNode *node7 = [[YFNode alloc] init];
    node7.isExpanded = NO;
    node7.title = @"三角函数";
    
    node0.sonNodes = [NSMutableArray arrayWithObjects:node2, node3, nil];
    node2.sonNodes = [NSMutableArray arrayWithObjects:node4, nil];
    node3.sonNodes = [NSMutableArray arrayWithObjects:node5, node6, nil];
    node5.sonNodes = [NSMutableArray arrayWithObjects:node7, nil];
    
    self.dataArray = [NSMutableArray arrayWithObjects:node0,node1, nil];
    
    for (YFNode *node in self.dataArray) {
        NSLog(@"node.title = %@", node.title);
        for (YFNode *sonNode in node.sonNodes) {
            NSLog(@"sonNode.title = %@", sonNode.title);
        }
    }
     //*/
    
}

/*---------------------------------------
 初始化将要显示的cell的数据
 --------------------------------------- */
- (void)reloadDataForDisplayArray{

    for (YFNode *node in self.dataArray) {
        [self.displayArray addObject:node];
        
        if (node.isExpanded) {
            [self findSonNodes:node];
        }
    }
    
    for (YFNode *node in self.displayArray) {
        NSLog(@"node.title = %@", node.title);
        for (YFNode *sonNode in node.sonNodes) {
            NSLog(@"sonNode.title = %@", sonNode.title);
        }
    }
}

- (void)findSonNodes:(YFNode *)node {

    for (YFNode *sonNode in node.sonNodes) {
        [self.displayArray addObject:sonNode];
        
        [self findSonNodes:sonNode];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.displayArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YFNode *node = self.displayArray[indexPath.row];

//    for (YFNode *node in self.displayArray) {
//        NSLog(@"title = %@", node.title);
//    }
    NSLog(@"row = %zd", indexPath.row);
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = node.title;
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    for (YFNode *node in self.displayArray) {
        NSLog(@"node.title = %@", node.title);
        for (YFNode *sonNode in node.sonNodes) {
            NSLog(@"sonNode.title = %@", sonNode);
        }
    }

    [self reloadData:indexPath.row];
//    NSLog(@"删除后 displayArray = %@", self.displayArray);
//    for (YFNode *node in self.displayArray) {
//        NSLog(@"node.title = %@", node.title);
//    }
}

- (void)reloadData:(NSInteger)row {

    [self.displayArray removeAllObjects];
    _count = 0;
    NSLog(@"count = %zd", self.dataArray.count);
    
    for (YFNode *node in self.dataArray) {  // n0  n1
        NSLog(@"node.title = %@, node = %p", node.title, node);

        // 找到根节点
        [self.displayArray addObject:node];  // n0

        // 改变展开状态
        if (_count == row) {   // n0 开
            node.isExpanded = !node.isExpanded;
        }
        _count++;   // _cnt = 1
        if (node.isExpanded) { // 根节点有子节点
            [self findSonNodes:node row:row];
        }
    
    }
    
    [self.tableView reloadData];
}

- (void)findSonNodes:(YFNode *)node row:(NSInteger)row{  // n0   0

    for (YFNode *sonNode in node.sonNodes) {  // n2  n3
        NSLog(@"sonNode.title = %@", sonNode.title);
        NSLog(@"_count = %zd", _count);
        // 找到子节点
        [self.displayArray addObject:sonNode];  // n2
        
        // 改变展开状态
        if (_count == row) {  // 1 != 0
            sonNode.isExpanded = !sonNode.isExpanded;
        }
        
        _count++;  // _cnt = 2;
        
        if (sonNode.isExpanded) {
            [self findSonNodes:sonNode row:row];
        }
    }
}

#pragma mark - setter
- (NSMutableArray *)displayArray {

    if (!_displayArray) {
        _displayArray = [NSMutableArray array];
    }
    return _displayArray;
}

- (NSMutableArray *)dataArray {

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



@end
