//
//  SecondViewController.m
//  MutableMenuTableView
//
//  Created by 张国庆 on 16/4/28.
//  Copyright © 2016年 zgq. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondMenuData.h"

@interface SecondViewController ()
@property (nonatomic,strong)SecondMenuData *secondData;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=self.item.title;
    self.secondData=[[SecondMenuData alloc]init];
    oldindex=-1;
}
#pragma mark - Table view data source
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MyItem *item=[self.secondData.tableViewData objectAtIndex:section];
    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
    headview.backgroundColor=[UIColor whiteColor];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 1, self.view.frame.size.width, 43)];
    btn.tag=1000+section;
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn addTarget:self action:@selector(headViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:item.title forState:UIControlStateNormal];
    [headview addSubview:btn];
    return headview;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return [self.secondData.tableViewData  count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        MyItem *item=[self.secondData.tableViewData objectAtIndex:section];
        return  flag[section]?[item.subItems count]:0;
    
   
    
    // Return the number of rows in the section.
    
    //return [[MenuData sharedMenuData].tableViewData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"cell";
    UITableViewCell * itemCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (itemCell == nil) {
        itemCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];;
        
    }
    if([self.secondData.tableViewData count])
    {
        MyItem *item=[self.secondData.tableViewData objectAtIndex:indexPath.section];
        if([item.subItems count])
        {
            MyItem *item1=[item.subItems objectAtIndex:indexPath.row];
            itemCell.textLabel.text=item1.title;

        }
    }
    
    return itemCell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)headViewClicked:(id)sender
{
    
    UIButton *headBtn=(UIButton *)sender;
    if(oldindex!=headBtn.tag-1000)
    {
        flag[oldindex]=NO;
    }
    flag[headBtn.tag-1000]=!flag[headBtn.tag-1000];
    
    [self.secondTableView reloadData];
    oldindex =headBtn.tag-1000;
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
