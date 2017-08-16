//
//  SheetInsertView.h
//  DatabaseMangerDemo
//
//  Created by LccLcc on 15/12/9.
//  Copyright © 2015年 LccLcc. All rights reserved.
//  编辑表界面

#import "DataInsertView.h"


@protocol SheetInsertViewDelegate <NSObject>

//新建失败
- (void)insertError;
//新建成功
- (void)insertSuccess;
//关闭
- (void)closeInsertlView;

@end


@interface SheetInsertView : UIView<UITableViewDelegate,UITableViewDataSource>

//需要创建的cell个数
@property(nonatomic,assign)NSInteger cellCount;
//表名
@property(nonatomic,strong)NSString *sheetTitle;
@property(nonatomic,weak)id<SheetInsertViewDelegate>delegate;
@property(nonatomic,strong)UITableView *tableView;

@end
