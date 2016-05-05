//
//  SheetInsertView.m
//  DatabaseMangerDemo
//
//  Created by LccLcc on 15/12/9.
//  Copyright © 2015年 LccLcc. All rights reserved.
//
#import "Define.h"
#import "SheetInsertView.h"
#import "LccCell.h"
#import "LCCSqliteManager.h"
@implementation SheetInsertView
{

    //接收字段
    NSMutableArray *_attributes;
    //标题
    UITextField *_titleTextFiled;
    //manager
    LCCSqliteManager *_manager;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //背景
        UIView * blackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWidth, KHeight)];
        [self addSubview:blackgroundView];
        blackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];

        
        //表视图
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake((KWidth - 300)/2, 70, 300, KHeight - 250)];
        if (iPhone4) {
            self.tableView.frame = CGRectMake((KWidth - 300)/2, 20, 300, KHeight - 250);
        }
        
        [blackgroundView addSubview:self.tableView ];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //表视图头视图
        UIView * backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 180, 40)];
        _titleTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(60 , 0, 180 , 40)];
        _titleTextFiled.borderStyle = UITextBorderStyleRoundedRect;
        [backGroundView addSubview:_titleTextFiled];
        _titleTextFiled.placeholder = @"输入标题";
        _titleTextFiled.backgroundColor = [UIColor colorWithWhite:.95 alpha:1];
        self.tableView.tableHeaderView=backGroundView;
        
        
        //确定按钮
        UIButton *ensureButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 70, 40, 40)];
        if (iPhone4) {
            ensureButton.frame = CGRectMake(10, 30, 40, 40);
        }
        [blackgroundView addSubview:ensureButton];
        [ensureButton setImage:[UIImage imageNamed:@"btn_save"] forState:UIControlStateNormal];
        [ensureButton addTarget:self action:@selector(_insertSheetActon) forControlEvents:UIControlEventTouchUpInside];

        
        
        
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

#pragma mark - Action
- (void)_insertSheetActon{
    
    _attributes = [[NSMutableArray alloc]init];
    _sheetTitle = _titleTextFiled.text;
    [self endEditing:YES];
    
    if ([_sheetTitle  isEqual: @""]) {
        [self.delegate insertError];
        return;
    }
    
    NSLog(@"self.cellCount = %ld",(long)self.cellCount);
    for (int i = 0; i < self.cellCount; i ++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        LccCell *pCell = [self.tableView cellForRowAtIndexPath:path ];
        NSLog(@"pcell  = %@",pCell);
        if (pCell != nil&&[pCell.textFiled.text isEqualToString:@""]) {
            [self.delegate insertError];
            return;
        }
        [_attributes addObject:pCell.textFiled.text];
    }
    //创建新表
//    BOOL result =  [_manager createSheetWithName:_sheetTitle attributes:_attributes primaryKey:nil];
    BOOL result =  [_manager createSheetWithSheetHandler:^(LCCSqliteSheetHandler *sheet) {
        sheet.sheetName = _sheetTitle;
        sheet.sheetField = _attributes; 
    }];

    if (result == YES) {
        
        [self _clear];
        [self.delegate insertSuccess];
        
    }
    if (result == NO) {
        
        [self.delegate insertError];

        
    }
    
}

- (void)_deleateAction{
    
    [self.delegate closeInsertlView];
    
}

- (void)_clear{
    
    [self endEditing:YES];
    _titleTextFiled.text = @"";
    for (int i = 0; i < self.cellCount; i ++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        LccCell *pCell = [self.tableView cellForRowAtIndexPath:path ];
        pCell.textFiled.text = @"";
    }
    
}


#pragma mark - TableViewDelegate


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return 1;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.cellCount;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LccCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sheetCell"];
    if (cell == nil) {
        cell = [[LccCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sheetCell" andWidth:300];
    }
//    cell.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textFiled.placeholder = [NSString stringWithFormat:@"输入字段%ld:",(long)indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}



@end
