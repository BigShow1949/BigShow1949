//
//  ViewController.m
//  talbeViewDeleteTEST
//
//  Created by zhht01 on 16/1/14.
//  Copyright © 2016年 BigShow1949. All rights reserved.
//


#import "YFTableViewDelAll.h"
#import "YFBottomEditView.h"
#import "YFTableViewDelAllCell.h"

@interface YFTableViewDelAll ()<UITableViewDataSource, UITableViewDelegate,YFBottomEditViewDelegate>

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) NSMutableArray *datas;
// 建立一个装有全选和删除按钮的一个view
@property (nonatomic, strong) YFBottomEditView *bottomEditView;

// 创建一个字典来接收 即将删除内容
@property (nonatomic, strong) NSMutableDictionary *deletDic;


@end

@implementation YFTableViewDelAll

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"全选删除";
    _deletDic = [NSMutableDictionary dictionary];
    
    [self.view addSubview:self.tableView];
    
    [self setupNav];
}

- (void)setupNav {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editionRemove:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回箭头" style:UIBarButtonItemStylePlain target:self action:@selector(backOrSelectAll:)];
}

- (void)editionRemove:(UIBarButtonItem *)button {
    
    if ([button.title isEqual:@"编辑"]) {
        
        [button setTitle:@"取消"];
        self.navigationItem.leftBarButtonItem.title = @"全选";
        
        [self.deletDic removeAllObjects];
        
        [self.bottomEditView show];
        [self.tableView setEditing:YES animated:YES];
        
    } else if ([button.title isEqual:@"取消"]) {
        
        [button setTitle:@"编辑"];
        self.navigationItem.leftBarButtonItem.title = @"返回箭头";
        
        [self.bottomEditView hidden];
        [self.tableView setEditing:NO animated:YES];
        
    }
}

- (void)backOrSelectAll:(UIBarButtonItem *)button {
    
    if ([button.title isEqual:@"返回箭头"]) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if ([button.title isEqual:@"全选"]) {
        button.title = @"取消全选";
        
        // 全选
        [self.datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:idx inSection:0];
            [self.deletDic setObject:self.datas[path.row] forKey:path];
            [self.tableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionNone];
        }];
        
        // 改变"删除"颜色
        self.bottomEditView.deleteBtn.enabled = YES;
        
    }else if ([button.title isEqual:@"取消全选"]) {
        button.title = @"全选";
        
        // 取消全选
        [self.deletDic removeAllObjects];
        [self.datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:idx inSection:0];
            [self.tableView deselectRowAtIndexPath:path animated:YES];
        }];
        
        // 改变"删除"颜色
        self.bottomEditView.deleteBtn.enabled = NO;
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YFTableViewDelAllCell *cell = [YFTableViewDelAllCell cellWithtableView:tableView];

    cell.textLabel.text = self.datas[indexPath.row];

    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.navigationItem.rightBarButtonItem.title isEqual:@"取消"]) {  // 处在编辑状态
        
        [self.deletDic setObject:self.datas[indexPath.row] forKey:indexPath];
        
        // 判断是否全选了
        if (self.deletDic.count == self.datas.count) {
            self.navigationItem.leftBarButtonItem.title = @"取消全选";
        }
        
        // 改变"删除"颜色
        self.bottomEditView.deleteBtn.enabled = YES;
    }
    
    NSLog(@"subviewss = %@", tableView.subviews);
//    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 不注释,编辑状态下,没有选中效果
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([self.navigationItem.rightBarButtonItem.title isEqual:@"取消"]) {  // 处在编辑状态
        [self.deletDic removeObjectForKey:indexPath];
        self.navigationItem.leftBarButtonItem.title = @"全选";
        
        // 没有选中项 改变"删除"颜色
        NSArray *deleDatas = [NSArray arrayWithArray:[self.deletDic allValues]];
        if (deleDatas.count == 0) {  
            self.bottomEditView.deleteBtn.enabled = NO;
        }
    }
    NSLog(@"subviewss 取消了 = %@", tableView.subviews);

}



- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;;
    
}

#pragma mark - YFBottomEditViewDelegate
- (void)deleteSelectItem {
    
    // 测试
    NSArray *indexPathsText =[self.tableView indexPathsForSelectedRows];
    NSLog(@"indexPathsText = %@", indexPathsText);
    
    // 测试结束
    NSArray *deleDatas = [NSArray arrayWithArray:[self.deletDic allValues]];
    NSArray *indexPaths = [NSArray arrayWithArray:[self.deletDic allKeys]];
    
    [self.datas removeObjectsInArray:deleDatas];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
    [self.deletDic removeAllObjects];
    
    [self.tableView reloadData];
    
}


#pragma mark - 懒加载
- (YFBottomEditView *)bottomEditView {
    
    if (_bottomEditView == nil) {
        _bottomEditView = [[YFBottomEditView alloc] init];
        _bottomEditView.backgroundColor = [UIColor lightGrayColor];;
        _bottomEditView.dataSource = self;
    }
    return _bottomEditView;
}

- (NSMutableArray *)datas
{
    if (!_datas) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@"123",@"234",@"345"]];
        _datas = arr;
    }
    return _datas;
    
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        CGFloat app_width = [UIScreen mainScreen].bounds.size.width;
        CGFloat app_height = [UIScreen mainScreen].bounds.size.height;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, app_width, app_height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.allowsSelectionDuringEditing = YES;
    }
    return _tableView;
}



@end
