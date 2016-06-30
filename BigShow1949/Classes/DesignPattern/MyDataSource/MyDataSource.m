//
//  MyDataSource.m
//  test
//
//  Created by 杨帆 on 16/6/29.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "MyDataSource.h"

@interface MyDataSource ()
{
    NSArray *_items;
    NSString       *_identifier;
    cellBackBlock  myTestBlock;
}

@end

@implementation MyDataSource


-(id)initWithItems:(NSArray *)array cellIdentifier:(NSString *)identifier andCallBack:cellBackBlock{
    
    self = [super init];
    if (self) {
        _items = [NSMutableArray arrayWithArray:array];
        _identifier = identifier;
        myTestBlock = cellBackBlock;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
    
    if (cell == nil) {
        
        
//        //        二种加载方式
//        //        从XIB 中加载
//        cell = [[NSBundle mainBundle]loadNibNamed:_identifier owner:self options:nil][0];
        
        //        代码加载
        cell = [[NSClassFromString(_identifier) alloc]
                initWithStyle:UITableViewCellStyleValue1
                reuseIdentifier:_identifier];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    id theme = _items[indexPath.row];
    
    myTestBlock(cell,theme);
    return cell;  
}

@end
