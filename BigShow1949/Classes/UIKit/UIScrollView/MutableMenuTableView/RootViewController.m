//
//  RootViewController.m
//  MutableMenuTableView
//
//  Created by 张国庆 on 16/4/27.
//  Copyright © 2016年 zgq. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.menuData = [[MenuData alloc] init];
        
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.menuData = [[MenuData alloc] init];
    self.myIndexPath=nil;
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [_menuData.tableViewData count];
    //return [[MenuData sharedMenuData].tableViewData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString  stringWithFormat: @"Cell%ld",(long)indexPath.row];
    MenuItemCell * itemCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (itemCell == nil) {
        itemCell = [[[NSBundle mainBundle] loadNibNamed:@"MenuItemCell" owner:nil options:nil]lastObject];
        
    }
    
    MyItem *item;
    item = [_menuData.tableViewData objectAtIndex:indexPath.row];
    
    itemCell.item = item;
    [itemCell setLevel:item.level];
   
    return itemCell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MenuItemCell * cell;
    cell = (MenuItemCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.item.isSubItemOpen)
    {
        //remove
        NSArray * arr;
        arr = [_menuData cascadingDeletePaths:indexPath];
        if ([arr count] >0) {
            [tableView deleteRowsAtIndexPaths: arr withRowAnimation:UITableViewRowAnimationBottom];
            self.myIndexPath=indexPath;
        }
        else
        {
            MyItem *item;
            item = [_menuData.tableViewData objectAtIndex:indexPath.row];
            SecondViewController *second=[[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil];
            second.item=item;
            [self.navigationController pushViewController:second animated:YES];
        }
    }
    else
    {
        //insert
        NSArray * arr;
        arr = [_menuData cascadingInsertCellPaths:indexPath];
        if ([arr count] >0) {
            [tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationBottom];
            self.myIndexPath=indexPath;
        }
        else
        {
            MyItem *item;
            item = [_menuData.tableViewData objectAtIndex:indexPath.row];
            SecondViewController *second=[[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil];
            second.item=item;
            [self.navigationController pushViewController:second animated:YES];
        }
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
