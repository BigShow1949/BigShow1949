//
//  MyBaseDataSource.m
//  BigShow1949
//
//  Created by 杨帆 on 16/6/30.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "MyBaseDataSource.h"
#import "UITableViewCell+YFDataSource.h"

@interface MyBaseDataSource()

@end

@implementation MyBaseDataSource

// 初始化
- (id)initWithServerData:(NSArray *)serverData
       andCellIdentifier:(NSString *)identifier
{
    self = [super init];
    if(self)
    {
        self.serverData = serverData;           // 数据
        self.cellIdentifier = identifier;     // 复用
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.serverData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    // 如果需要就写在这里, 不需要就写在子类
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    id data = self.serverData[indexPath.row];
    
    [cell configCellWithEntity:data];
    
    if (self.cellBackBlock) {
        self.cellBackBlock(cell,data);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.cellSelectedBlock(indexPath);
}


@end
