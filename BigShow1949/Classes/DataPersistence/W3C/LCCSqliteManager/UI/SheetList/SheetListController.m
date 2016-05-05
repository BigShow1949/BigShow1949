//
//  SheetListController.m
//  DatabaseMangerDemo
//
//  Created by LccLcc on 15/11/27.
//  Copyright © 2015年 LccLcc. All rights reserved.
//


#import "Define.h"
#import "SheetListController.h"
#import "LCCSqliteManager.h"
#import "DataListController.h"
#import "LccButton.h"
#import "SheetInsertView.h"
@interface SheetListController ()<UITableViewDelegate,UITableViewDataSource,SheetInsertViewDelegate>

{
    //新建表时需要传入的字段数
    NSInteger _attributesCount;
    //输入框继续按钮
    UIAlertAction *_nextAction;
    //数据库管家
    LCCSqliteManager *_manager;
    //新建表页面
    SheetInsertView *_sheetInsertView;
    
}

@end

@implementation SheetListController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createButtonItem];

    
    //数据库操作
    _manager = [LCCSqliteManager shareInstance];
    [_manager openSqliteFile:@"database"];
    
    
    //我帮你们建的两张表
    [_manager createSheetWithSheetHandler:^(LCCSqliteSheetHandler *sheet) {
       sheet.sheetName = @"我的好友列表";
        sheet.sheetType = LCCSheetTypeVariable;
        sheet.sheetField = @[@"微信号",@"昵称",@"备注",@"是否屏蔽"];
        sheet.primaryKey = @[@"微信号",@"昵称"];
    }];
    
    [_manager createSheetWithSheetHandler:^(LCCSqliteSheetHandler *sheet) {
        sheet.sheetName = @"好友详细资料";
        sheet.sheetType = LCCSheetTypeVariable;
        sheet.sheetField = @[@"微信号",@"昵称",@"头像",@"签名",@"性别",@"主页"];
        
        
        sheet.forgienKey = @[@"微信号",@"昵称"];
        sheet.referencesSheetName = @"我的好友列表";
        sheet.referenceskey = @[@"微信号",@"昵称"];
        sheet.updateReferencesType = LCCSqliteReferencesKeyTypeCasCade;
        sheet.deleateReferencesType = LCCSqliteReferencesKeyTypeCasCade;
    }];

//    读取列表
    _sheetListArray = [_manager getAllSheetNames];
    
    //表视图
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - 导航栏按钮
- (void)_createButtonItem{
    
    LccButton * createButton = [LccButton buttonWithType:UIButtonTypeSystem];
    [createButton setTitle:@"新建表" forState:UIControlStateNormal];
    [createButton addTarget:self action:@selector(_addSheetAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *createButtonItem = [[UIBarButtonItem alloc]initWithCustomView:createButton];
    [self.navigationItem setRightBarButtonItem: createButtonItem];
    

}

#pragma mark - Action
- (void)_addSheetAction:(id)sender {
    
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"创建新表"
                                                                   message:@"请输入新表的字段数"
                                                            preferredStyle:UIAlertControllerStyleAlert];

    [alter addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"请输入一个1～5的整数";
        [textField addTarget:self action:@selector(_inputChangeAction:) forControlEvents:UIControlEventEditingChanged];
        
    }];

    _nextAction = [UIAlertAction actionWithTitle:@"继续" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _sheetInsertView = [[SheetInsertView alloc]initWithFrame:CGRectMake(0, -KHeight, KWidth, KHeight) ];
        _sheetInsertView.cellCount = _attributesCount;
        _sheetInsertView.delegate = self;
        [self.navigationController.view addSubview:_sheetInsertView];
        [self.navigationController.view bringSubviewToFront:_sheetInsertView];
        
        [UIView animateWithDuration:.3 animations:^{
            _sheetInsertView.frame = CGRectMake(0, 0, KWidth, KHeight);
        } completion:nil];

    }];
    
    _nextAction.enabled = NO;
    UIAlertAction *cannleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alter addAction:_nextAction];
    [alter addAction:cannleAction];
    [self presentViewController:alter animated:YES completion:nil];
    

}


- (void)_inputChangeAction:(UITextField *)pTextFiled{
    
    _nextAction.enabled = NO;
    NSLog(@"输入的字段数＝%@",pTextFiled.text);
    if ([pTextFiled.text integerValue] >= 1 && [pTextFiled.text integerValue] <=5) {
        _nextAction.enabled = YES;
        _attributesCount = [pTextFiled.text integerValue];
    }
    
}



#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.sheetListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sheetCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sheetCell"];
    }
    cell.textLabel.text = _sheetListArray[indexPath.row];
    return cell;
    
}


#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    DataListController *dataViewController = (DataListController*)[storyboard instantiateViewControllerWithIdentifier:@"DataList" ];
    DataListController *dataViewController = [[DataListController alloc] init];
    dataViewController.sheetTitle = _sheetListArray[indexPath.row];
    [self.navigationController pushViewController:dataViewController animated:YES];
    //导航栏tintcolor(Back按钮颜色)
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //删除对应表
        [_manager deleateSheetWithName:cell.textLabel.text];
        //读取新表名，删除并刷新
        _sheetListArray = [_manager getAllSheetNames];
        NSLog(@"删除完毕,删除后数据库内表如下:  %@",_sheetListArray);
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
    
}


#pragma mark - SheetInsertViewDelegate
//关闭
- (void)closeInsertlView{
    
    [_sheetInsertView endEditing:YES];
    [UIView animateWithDuration:.2 animations:^{
        _sheetInsertView.frame = CGRectMake(0, -KHeight, KWidth, KHeight);
    } completion:nil];
    
}

//新建成功
-(void)insertSuccess{
    //更新表视图
    _sheetListArray = [_manager getAllSheetNames];
    [self.tableView reloadData];
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:@"新建成功"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cannleAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    [alter addAction:cannleAction];
    [self presentViewController:alter animated:YES completion:nil];
    
}

-(void)insertError{
    
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:@"创建失败，请检查"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cannleAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    [alter addAction:cannleAction];
    [self presentViewController:alter animated:YES completion:nil];
    
}



@end
