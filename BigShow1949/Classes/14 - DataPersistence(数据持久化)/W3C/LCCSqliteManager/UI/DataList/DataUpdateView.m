//
//  DataUpdateView.m
//  DatabaseMangerDemo
//
//  Created by LccLcc on 15/12/11.
//  Copyright © 2015年 LccLcc. All rights reserved.
//



#import "Define.h"
#import "DataUpdateView.h"
#import "LccCell.h"
#import "LCCSqliteManager.h"

#import "DataEditView.h"

@interface DataUpdateView () <DataEditViewDelegate>
{
    //    LCCSqliteManager *_manager;
    DataEditView *_dataEditView;
}
@end

@implementation DataUpdateView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _dataEditView = [[DataEditView alloc] initWithFrame:frame];
        _dataEditView.delegate = self;
        [self addSubview:_dataEditView];
        
    }
    
    return self;
    
}

- (void)setSheetTitle:(NSString *)sheetTitle {

    _sheetTitle = sheetTitle;
    
    _dataEditView.placeholders = [[LCCSqliteManager shareInstance] getSheetAttributesWithSheet:sheetTitle];
    [_dataEditView.tableView reloadData];
}

- (void)setUpdateArray:(NSArray *)updateArray {

    _updateArray = updateArray;
    
    _dataEditView.texts = updateArray;
    [_dataEditView.tableView reloadData];
    
    
    // 搜索条件
    // 获取字段
    NSArray *attributes = [[LCCSqliteManager shareInstance] getSheetAttributesWithSheet:self.sheetTitle];
    
    // 拼接
    self.updateCondition = @"";
    for (int i = 0; i < attributes.count; i ++) {
        if (i == attributes.count - 1) {
            NSString *pstr = [NSString stringWithFormat:@" \"%@\"=\'%@\' ",attributes[i], updateArray[i]];
            self.updateCondition = [self.updateCondition stringByAppendingString:pstr];
            break;
        }
        NSString *pstr = [NSString stringWithFormat:@" \"%@\"=\'%@\' and", attributes[i], updateArray[i]];
        self.updateCondition = [self.updateCondition stringByAppendingString:pstr];
        
    }
    
    NSLog(@"updateCondition = %@", self.updateCondition);
    
}




#pragma mark -DataEditViewDelegate
- (void)ensureAction:(NSArray *)dataArray {
    
    NSLog(@"更新的数据 ＝ %@",dataArray);
    NSLog(@"updateCondition = %@", self.updateCondition);
    LCCSqliteManager *manger = [LCCSqliteManager shareInstance];
   BOOL result = [manger updateDataToSheet:self.sheetTitle withData:dataArray where:self.updateCondition];
    
    if (result == YES) {

        [self.delegate updateSuccess];
        
    }
    
    if (result == NO) {
        
        [self.delegate updateError];
        
    }
    
}

- (void)closeAction {
    [self removeFromSuperview];
}




@end
