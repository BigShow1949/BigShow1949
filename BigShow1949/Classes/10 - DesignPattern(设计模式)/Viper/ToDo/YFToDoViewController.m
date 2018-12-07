//
//  YFToDoViewController.m
//  BigShow1949
//
//  Created by big show on 2018/12/7.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFToDoViewController.h"
#import "YFToDoItem.h"

@interface YFToDoViewController ()
@property (nonatomic) NSMutableArray *todoList;

@end

@implementation YFToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
}

- (void)setupNav {
    UIBarButtonItem *addTodoItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = addTodoItem;
}


- (void)add {
    YFToDoItem *item = [[YFToDoItem alloc] init];
    item.text = @"2018";
    [self.presenter addToDoItem:item];
}

#pragma mark - ToDoViewProtocol
- (void)showAddedItem:(YFToDoItem *)item {
    [self.todoList addObject:item];
    [self.tableView reloadData];
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.todoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YFToDoTableViewCell"];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"YFToDoTableViewCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    YFToDoItem *item = self.todoList[indexPath.row];
    cell.textLabel.text = item.text;
    return cell;
}

- (NSMutableArray *)todoList {
    if (!_todoList) {
        YFToDoItem *item = [[YFToDoItem alloc] init];
        item.text = @"TEST";
        _todoList = [NSMutableArray arrayWithObject:item];
    }
    return _todoList;
}

@end
