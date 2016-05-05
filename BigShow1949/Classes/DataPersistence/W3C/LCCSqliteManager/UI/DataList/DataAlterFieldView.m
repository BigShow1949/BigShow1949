//
//  DataAlterFieldView.m
//  BigShow1949
//
//  Created by zhht01 on 16/4/21.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "DataAlterFieldView.h"
#import "LCCSqliteManager.h"
#import "LccCell.h"
#import "Define.h"
#import "DataEditView.h"

@interface DataAlterFieldView ()<DataEditViewDelegate>
{
    //接收字段(新增的表字段)
    NSMutableArray *_attributes;

    LCCSqliteManager *_manager;
    
    DataEditView *_dataEditView;
    
}

@end


@implementation DataAlterFieldView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        // 创建
        _dataEditView = [[DataEditView alloc] initWithFrame:frame];
        _dataEditView.delegate = self;
        [self addSubview:_dataEditView];
        
    }
    
    return self;
}

- (void)setCellCount:(NSInteger)cellCount {

    _cellCount = cellCount;
    
    // 给cell 赋值
//    _dataEditView.cellCount = self.cellCount;
    
    NSMutableArray *placeholders = [NSMutableArray array];
    for (NSInteger i = 0; i < cellCount; i++) {
        
        NSString *placeholderStr =  [NSString stringWithFormat:@"输入字段%zd:", i];
        [placeholders addObject:placeholderStr];
    }
    
    _dataEditView.placeholders = placeholders;
    [_dataEditView.tableView reloadData];
}


#pragma mark - DataEditViewDelegate
- (void)ensureAction:(NSArray *)dataArray {

//    _attributes = [NSMutableArray array];
//    
//    NSLog(@"self.cellCount = %ld",(long)self.cellCount);
//    for (int i = 0; i < self.cellCount; i ++) {
//        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
//        LccCell *pCell = [self.tableView cellForRowAtIndexPath:path ];
//        NSLog(@"pcell  = %@",pCell);
//        if (pCell != nil&&[pCell.textFiled.text isEqualToString:@""]) {
//            //            [self.delegate insertError];
//            return;
//        }
//        [_attributes addObject:pCell.textFiled.text];
//    }
    
    
    // 新增表字段
    BOOL result = [[LCCSqliteManager shareInstance] addColumnToSheet:self.sheetTitle withAttributeArray:dataArray];
    
    if (result == YES) {
        NSLog(@"成功");
        //        [self _clear];
        //        [self.delegate insertSuccess];
        [self.delegate alterFieldSuccess];
        
    }
    if (result == NO) {
        NSLog(@"失败");
        //        [self.delegate insertError];
    
    }
    
    
}

- (void)closeAction {
    [self removeFromSuperview];
}



@end
