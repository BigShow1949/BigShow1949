//
//  InsertView.m
//  DatabaseMangerDemo
//
//  Created by LccLcc on 15/12/3.
//  Copyright © 2015年 LccLcc. All rights reserved.
//

#import "Define.h"
#import "DataInsertView.h"
#import "LccCell.h"
#import "LCCSqliteManager.h"

#import "DataEditView.h"

@interface DataInsertView ()<DataEditViewDelegate>

@end

@implementation DataInsertView
{

    LCCSqliteManager *_manager;
    DataEditView *_dataEditView;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 创建
        _dataEditView = [[DataEditView alloc] initWithFrame:frame];
        _dataEditView.delegate = self;
        [self addSubview:_dataEditView];
    }
    
    return self;
}

- (void)setSheetTitle:(NSString *)sheetTitle {

    _sheetTitle = sheetTitle;
    
    NSArray *attribute = [[LCCSqliteManager shareInstance] getSheetAttributesWithSheet:sheetTitle];
    
    _dataEditView.placeholders = attribute;
    [_dataEditView.tableView reloadData];
    
}




#pragma mark -Action
//确定成功
- (void)ensureAction:(NSArray *)dataArray {

    NSLog(@"插入的数据 ＝ %@",dataArray);
    LCCSqliteManager *manger = [LCCSqliteManager shareInstance];

    BOOL result =  [manger insertDataToSheet :self.sheetTitle withData:dataArray];

    if (result == YES) {
        [self.delegate insertSuccess];
    }

    if (result == NO) {
        [self.delegate insertError];
    }
}
//关闭
- (void)closeAction {

    [self removeFromSuperview];
}




@end
