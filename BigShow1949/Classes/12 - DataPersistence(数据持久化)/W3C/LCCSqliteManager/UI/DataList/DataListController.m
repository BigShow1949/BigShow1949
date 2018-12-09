//
//  SheetDataController.m
//  DatabaseMangerDemo
//
//  Created by LccLcc on 15/12/1.
//  Copyright © 2015年 LccLcc. All rights reserved.
//

#import "DataListController.h"
#import "LCCSqliteManager.h"
#import "LccButton.h"
#import "LccDataCell.h"
#import "DataInsertView.h"
#import "DataUpdateView.h"
#import "Define.h"
#import "DataAlterFieldView.h"
@interface DataListController ()<UITableViewDelegate,UITableViewDataSource,InsertViewDelegate,DataUpdateViewDelegate,DataAlterFieldViewDelegate>

{
    
    //数据库
    LCCSqliteManager * _manager;
    //接收所有数据
    NSArray * _allDataArray;
    //插入数据页面
    DataInsertView * _dataInsertView;
    // 插入表字段
    DataAlterFieldView *_alterFieldView;
    //更新数据页面
    DataUpdateView * _dataUpdateView;
    //搜索条件
    NSString * _searchCondition;
    //删除条件
    NSString * _deleateCondition;
    //更新条件
    NSString * _updateCondition;
    
    //输入框继续按钮
    UIAlertAction *_nextAction;
    // 新增表字段的个数
    NSInteger _alterCount;


}

@end

@implementation DataListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.sheetTitle;
    
    [self setupNav];

    _manager = [LCCSqliteManager shareInstance];
    //获取到当前表的字段
    _attributesArray = [_manager getSheetAttributesWithSheet:self.sheetTitle];
    //获取到当前表内所有数据
    _allDataArray = [_manager getSheetDataWithSheet:self.sheetTitle];
    //初始化更新、查询、删除三个条件
    _deleateCondition = @"";
    _updateCondition = @"";
    _searchCondition = @"";
    //表视图
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

#pragma mark - TableViewDataSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _allDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}


#pragma mark - TableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * BGView = [[UIView alloc]init];
    BGView.backgroundColor = [UIColor whiteColor];
    
    long width2 = KWidth / 4;
    long xOffset = (width2 - 45)/2;
    NSArray *array = @[@"增",@"删",@"改",@"查"];
    for (int i = 0; i <= 3; i++) {
        LccButton *button = [LccButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.frame = CGRectMake(i*width2 + xOffset, 6, 45, 25);
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [BGView addSubview:button];
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, KWidth, 1)];
    line.backgroundColor = [UIColor grayColor];
    [BGView addSubview:line];
    
    
    long width = KWidth/_attributesArray.count;
    for (int i = 0; i < _attributesArray.count; i ++) {
        UILabel *attributetitle = [[UILabel alloc]initWithFrame:CGRectMake(i * width, 50, width, 20)];
        attributetitle.text = _attributesArray[i];
        [attributetitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        attributetitle.textColor = [UIColor grayColor];
        attributetitle.textAlignment = NSTextAlignmentCenter;
        
//        if ([attributetitle.text isEqualToString:[_manager getSheetPrimaryKeyWithSheet:self.title]]) {
//            attributetitle.textColor = [UIColor redColor];
//        }
        //主键查询
        for (id object in [_manager getSheetPrimaryKeyWithSheet:self.title]) {
            if ([attributetitle.text isEqualToString:object]) {
                attributetitle.textColor = [UIColor redColor];
            }
        }
        
        [BGView addSubview:attributetitle];
    }
    


    
    return BGView;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LccDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataCell"];
    //为空时  新建字段后,_allDataArray变了
//    if (cell == nil) {
        if (_allDataArray.count == 0) {
            cell = [[LccDataCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dataCell"];
        }
        else{
//            NSArray *tempArray = _allDataArray[indexPath.row];
            cell = [[LccDataCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dataCell" data:_allDataArray[indexPath.row]];
        }
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
//    }
    
    //不为空时，因为单元格复用,需要对cell的title进行重新赋值。
    for (int i = 0; i < _attributesArray.count; i ++) {
        UILabel *pLabel = [cell viewWithTag:i+100];
        pLabel.text = _allDataArray[indexPath.row][i];
    }

    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        LccDataCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        for (int i = 0; i < _attributesArray.count; i ++) {
            UILabel *pLabel = [cell viewWithTag:i+100];
            if (i == _attributesArray.count - 1) {
                NSString *pstr = [NSString stringWithFormat:@" \"%@\"=\'%@\'",_attributesArray[i],pLabel.text];
                _deleateCondition = [_deleateCondition stringByAppendingString:pstr];
                break;
            }
            NSString *pstr = [NSString stringWithFormat:@" \"%@\"=\'%@\' and",_attributesArray[i],pLabel.text];
            _deleateCondition = [_deleateCondition stringByAppendingString:pstr];

        }
        NSLog(@"删除条件 ＝ %@",_deleateCondition);
        
        //删除满足该条件的数据
        [_manager deleateDataFromSheet:self.title where:_deleateCondition];
        _deleateCondition = @"";
        //从新读取数据并刷新,判断是在哪里删除的数据
        _allDataArray = [_manager getSheetDataWithSheet:self.title];
        if (![_searchCondition  isEqual: @""]) {
            NSLog(@"搜索过了，返回搜索列表数据");
            _allDataArray = [_manager searchDataFromSheet:self.title where:_searchCondition];
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"弹出修改视图");
//    _updateCondition = @"";
//    LccDataCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSMutableArray *array = [[NSMutableArray alloc]init];
//    for (int i = 0; i < _attributesArray.count; i ++) {
//        UILabel *pLabel = [cell viewWithTag:i+100];
//        [array addObject:pLabel.text];
//        if (i == _attributesArray.count - 1) {
//            NSString *pstr = [NSString stringWithFormat:@" \"%@\"=\'%@\' ",_attributesArray[i],pLabel.text];
//            _updateCondition = [_updateCondition stringByAppendingString:pstr];
//            break;
//        }
//        NSString *pstr = [NSString stringWithFormat:@" \"%@\"=\'%@\' and",_attributesArray[i],pLabel.text];
//        _updateCondition = [_updateCondition stringByAppendingString:pstr];
//        
//    }
//
//    //数据更新视图
//    _dataUpdateView = [[DataUpdateView alloc]initWithFrame:CGRectMake(0, -KHeight, KWidth, KHeight)];
//    _dataUpdateView.delegate = self;
//    _dataUpdateView.sheetTitle = self.title;
//    _dataUpdateView.cellCount = _attributesArray.count;
//    _dataUpdateView.updateContidion = _updateCondition;
//    _dataUpdateView.dataArray = array;
//    
//    [self.navigationController.view addSubview:_dataUpdateView];
//    [self.navigationController.view bringSubviewToFront:_dataUpdateView];
//    
//    NSLog(@"更新条件＝%@",_updateCondition);
//    [UIView animateWithDuration:.3 animations:^{
//        _dataUpdateView.frame = CGRectMake(0, 0, KWidth, KHeight);
//    } completion:nil] ;
    
    // 数据更新
    _dataUpdateView = [[DataUpdateView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight)];
    _dataUpdateView.delegate = self;
    _dataUpdateView.sheetTitle = self.sheetTitle;
    _dataUpdateView.updateArray = _allDataArray[indexPath.row];
    [self.navigationController.view addSubview:_dataUpdateView];
}


#pragma mark - InsertViewDelegate
- (void)closeInsertlView{
    
    [_dataInsertView endEditing:YES];
    [UIView animateWithDuration:.2 animations:^{
        _dataInsertView.frame = CGRectMake(0, -KHeight, KWidth, KHeight);
    } completion:nil];

}

-(void)insertSuccess{
    //插入一条新数据后，所有搜索记录清空
    [self _clearCondition];
    _allDataArray = [_manager getSheetDataWithSheet:self.title];
    [self.tableView reloadData];

    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:@"插入成功"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cannleAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    [alter addAction:cannleAction];
    
    [self presentViewController:alter animated:YES completion:nil];

}

-(void)insertError{
    
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:@"插入失败，请检查"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cannleAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    [alter addAction:cannleAction];
    [self presentViewController:alter animated:YES completion:nil];

}

#pragma mark - DataUpdateViewDelegate
- (void)closeUpdateView{
    
    [_dataUpdateView endEditing:YES];
    NSLog(@"关闭更新视图");
    [UIView animateWithDuration:.2 animations:^{
        _dataUpdateView.frame = CGRectMake(0, -KHeight, KWidth, KHeight);
    } completion:nil];
    
}

-(void)updateSuccess{
    
    _updateCondition = @"";
    //从新读取数据并刷新,判断是在哪里更新的数据
    _allDataArray = [_manager getSheetDataWithSheet:self.sheetTitle];
    if (![_searchCondition  isEqual: @""]) {
        
        NSLog(@"搜索过了，返回搜索列表数据");
        _allDataArray = [_manager searchDataFromSheet:self.sheetTitle where:_searchCondition];
        
    }
    [self.tableView reloadData];
    
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:@"更新成功"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cannleAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self closeUpdateView];
    }];
    [alter addAction:cannleAction];
    [self presentViewController:alter animated:YES completion:nil];
    
}

-(void)updateError{
    
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:@"更新失败"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cannleAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    [alter addAction:cannleAction];
    [self presentViewController:alter animated:YES completion:nil];
    
}

#pragma mark - DataAlterFieldViewDelegate
- (void)alterFieldSuccess {
    
    _attributesArray = [_manager getSheetAttributesWithSheet:self.sheetTitle];
    _allDataArray = [_manager getSheetDataWithSheet:self.sheetTitle];

    [self.tableView reloadData];
    
    [self tipView];
}


#pragma mark - private
- (void)setupNav {

    LccButton * createButton = [LccButton buttonWithType:UIButtonTypeSystem];
    [createButton setTitle:@"新增字段" forState:UIControlStateNormal];
    [createButton addTarget:self action:@selector(rightBarClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *createButtonItem = [[UIBarButtonItem alloc]initWithCustomView:createButton];
    [self.navigationItem setRightBarButtonItem: createButtonItem];
}

- (void)rightBarClick {

    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"新增字段"
                                                                   message:@"请输入新增字段的个数"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alter addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"请输入一个1～5的整数";
        [textField addTarget:self action:@selector(_inputChangeAction:) forControlEvents:UIControlEventEditingChanged];
        
    }];
    
    _nextAction = [UIAlertAction actionWithTitle:@"继续" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//        _sheetInsertView = [[SheetInsertView alloc]initWithFrame:CGRectMake(0, -KHeight, KWidth, KHeight) ];
//        _sheetInsertView.cellCount = _attributesCount;
//        _sheetInsertView.delegate = self;
//        [self.navigationController.view addSubview:_sheetInsertView];
//        [self.navigationController.view bringSubviewToFront:_sheetInsertView];
//        
//        [UIView animateWithDuration:.3 animations:^{
//            _sheetInsertView.frame = CGRectMake(0, 0, KWidth, KHeight);
//        } completion:nil];
        
        _alterFieldView = [[DataAlterFieldView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight)];
        _alterFieldView.sheetTitle = self.sheetTitle;
        _alterFieldView.cellCount = _alterCount;
        _alterFieldView.delegate = self;
        [self.navigationController.view addSubview:_alterFieldView];
        
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
//        _attributesCount = [pTextFiled.text integerValue];
        _alterCount = [pTextFiled.text integerValue];
    }
    
}

- (void)tipView {

    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:@"更新成功"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cannleAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alter addAction:cannleAction];
    [self presentViewController:alter animated:YES completion:nil];
}

#pragma mark - Action
- (void)_buttonAction:(UIButton *)pButton{
    
    if (pButton.tag == 0) {
        
//        NSLog(@"插入数据");
//        [UIView animateWithDuration:.3 animations:^{
//            _dataInsertView.frame = CGRectMake(0, 0, KWidth, KHeight);
//        } completion:^(BOOL finished) {
//        }];
        
        //插入视图
        _dataInsertView = [[DataInsertView alloc]initWithFrame:CGRectMake(0, 0 , KWidth, KHeight)];
        _dataInsertView.delegate = self;
        _dataInsertView.sheetTitle = self.title;
        [self.navigationController.view addSubview:_dataInsertView];
        [self.navigationController.view bringSubviewToFront:_dataInsertView];

    }
    if (pButton.tag == 1) {
        
        pButton.selected = !pButton.selected;
        [self.tableView setEditing:pButton.selected animated:YES];
        
    }
    if (pButton.tag == 2) {
        
        NSLog(@"修改数据");
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"点击数据即可修改"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cannleAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
        [alter addAction:cannleAction];
        [self presentViewController:alter animated:YES completion:nil];

    }
    if (pButton.tag == 3) {
        
        NSLog(@"查找数据");
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"查找"
                                                                       message:@"请输入查找条件,条件为空则获取全部数据;查找条件举例:姓名=‘LCC’and年龄>20 "
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [alter addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
            textField.placeholder = @"提示:多个条件之间用and连接,符号注意区分大小写";
            
        }];
        
        UIAlertAction *searchAction = [UIAlertAction actionWithTitle:@"查找" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            _searchCondition = alter.textFields[0].text;
            NSLog(@"_searchCondition = %@", _searchCondition);
            if ([_searchCondition  isEqual: @""]) {
                
                _allDataArray = [_manager getSheetDataWithSheet:self.sheetTitle];
                [self.tableView reloadData];
                
            }
            else{
                
                _allDataArray = [_manager searchDataFromSheet:self.sheetTitle where:_searchCondition];
                [self.tableView reloadData];
                
            }
            
        }];
        
        UIAlertAction *cannleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        
        [alter addAction:cannleAction];
        [alter addAction:searchAction];
        _searchCondition = @"";
        [self presentViewController:alter animated:YES completion:nil];

    }

    
}

- (void)_clearCondition{
    
    _searchCondition = @"";
    _updateCondition = @"";
    _deleateCondition = @"";

}
@end
