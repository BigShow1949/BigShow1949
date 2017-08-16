//
//  QueryTableViewController.m
//  JKDBModel
//
//  Created by zx_04 on 15/7/3.
//  Copyright (c) 2015年 joker. All rights reserved.
//

#import "QueryTableViewController.h"
#import "User.h"

@interface QueryTableViewController ()

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation QueryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    if (_type == 4) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
        [button setTitle:@"点击加载更多" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(loadMore) forControlEvents:UIControlEventTouchUpInside];
        self.tableView.tableFooterView = button;
    }
    
    _data = [[NSMutableArray alloc] init];
    [self loadData];
}

- (void)loadData
{
    switch (_type) {
        case 1:
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSLog(@"第一条");
                User *user = [User findFirstByCriteria:@" WHERE age = 20 "];
                if (!user)  return;
                [self.data addObject:user];
                [self.tableView reloadData];
            });
            break;
        }
        case 2:
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSLog(@"小于20岁");
                [self.data addObjectsFromArray:[User findByCriteria:@" WHERE age < 20 "]];
                [self.tableView reloadData];
            });
            break;
        }
        case 3:
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSLog(@"全部");
                [self.data addObjectsFromArray:[User findAll]];
                [self.tableView reloadData];
            });
            break;
        }
        case 4:
        {
            [self loadMore];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)loadMore
{
    static int pk = 5;
    NSArray *array = [User findByCriteria:[NSString stringWithFormat:@" WHERE pk > %d limit 10",pk]];
    pk = ((User *)[array lastObject]).pk;
    [self.data addObjectsFromArray:array];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"queryCell"];
    
    UILabel *pkLabel = (UILabel *)[cell viewWithTag:101];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:102];
    UILabel *sexLabel = (UILabel *)[cell viewWithTag:103];
    UILabel *ageLabel = (UILabel *)[cell viewWithTag:104];
    
    User *user = [self.data objectAtIndex:indexPath.row];
    pkLabel.text = [NSString stringWithFormat:@"%d",user.pk];
    nameLabel.text = user.name;
    sexLabel.text = user.sex;
    ageLabel.text = [NSString stringWithFormat:@"%d",user.age];
    
    return cell;
}

@end
