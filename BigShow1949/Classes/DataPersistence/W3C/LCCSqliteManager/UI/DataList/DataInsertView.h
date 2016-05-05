//
//  InsertView.h
//  DatabaseMangerDemo
//
//  Created by LccLcc on 15/12/3.
//  Copyright © 2015年 LccLcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InsertViewDelegate <NSObject>

//插入失败
- (void)insertError;
//插入成功
- (void)insertSuccess;
//关闭
- (void)closeInsertlView;

@end


@interface DataInsertView : UIView //<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)NSString *sheetTitle;
@property(nonatomic,weak)id<InsertViewDelegate>delegate;
@property(nonatomic,strong)UITableView *tableView;



@end

