//
//  DataEditView.m
//  BigShow1949
//
//  Created by zhht01 on 16/4/22.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "DataEditView.h"
#import "Define.h"
#import "LccCell.h"
#import "LCCSqliteManager.h"


@interface DataEditView ()
{
    LCCSqliteManager *_manager;
}
@end

@implementation DataEditView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //背景
        UIView * blackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWidth, KHeight)];
        [self addSubview:blackgroundView];
        blackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        
        
        //表视图
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake((KWidth - 300)/2, 70, 300, KHeight - 250)];
        
        if (iPhone4) {
            self.tableView.frame = CGRectMake((KWidth - 300)/2, 40, 300, KHeight - 250);
        }
        
        [blackgroundView addSubview:self.tableView ];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        //确定按钮
        UIButton *ensureButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 70, 40, 40)];
        if (iPhone4) {
            ensureButton.frame = CGRectMake(10, 30, 40, 40);
        }
        [blackgroundView addSubview:ensureButton];
        [ensureButton setImage:[UIImage imageNamed:@"btn_save"] forState:UIControlStateNormal];
        [ensureButton addTarget:self action:@selector(_insertAction) forControlEvents:UIControlEventTouchUpInside];
        
        //删除按钮
        UIButton *deleateButton = [[UIButton alloc]initWithFrame:CGRectMake(KWidth - 50, 70, 40, 40)];
        if (iPhone4) {
            deleateButton.frame = CGRectMake(KWidth - 50, 30, 40, 40);
        }
        [blackgroundView addSubview:deleateButton];
        [deleateButton setImage:[UIImage imageNamed:@"btn_cannel"] forState:UIControlStateNormal];
        [deleateButton addTarget:self action:@selector(_deleateAction) forControlEvents:UIControlEventTouchUpInside];
        
        _manager = [LCCSqliteManager shareInstance];
    }
    
    return self;
    
}

#pragma mark - private
- (void)_insertAction {

    // 获取cell的值
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i < self.placeholders.count; i ++) { // 添加字段 字段不能为空  执行 texts空
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        LccCell *pCell = [self.tableView cellForRowAtIndexPath:path ];
        if (pCell.textFiled.text) {  // 有的text 是nil
            
            [dataArray addObject:pCell.textFiled.text];
        }else {
            [dataArray addObject:@""];
        }
    }
    
    // 过滤cell为空的情况
    if (!self.texts.count) { // 修改字段, 值可以为空
        
        for (int i = 0; i < self.placeholders.count; i ++) { // 添加字段 字段不能为空
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
            LccCell *pCell = [self.tableView cellForRowAtIndexPath:path ];
            NSLog(@"pcell  = %@",pCell);
            if (pCell != nil && [pCell.textFiled.text isEqualToString:@""]) {
                //            [self.delegate insertError];
                return;
            }
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(ensureAction:)]) {
        [self.delegate ensureAction:(NSArray *)dataArray];
    }
}

- (void)_deleateAction {

    if ([self.delegate respondsToSelector:@selector(closeAction)]) {
        [self.delegate closeAction];
    }
}

#pragma mark - TableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.placeholders.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LccCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inputCell"];
    if (cell == nil) {
        cell = [[LccCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"inputCell" andWidth:300];
    }
    cell.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //获取到这个表的字段
    cell.textFiled.placeholder = self.placeholders[indexPath.row];
    cell.textFiled.text = self.texts[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}



@end
