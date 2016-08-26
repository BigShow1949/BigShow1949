//
//  DataAlterFieldView.h
//  BigShow1949
//
//  Created by zhht01 on 16/4/21.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//
//  改变表字段

#import <UIKit/UIKit.h>


@protocol DataAlterFieldViewDelegate <NSObject>

// 增加字段成功
- (void)alterFieldSuccess;


@end


@interface DataAlterFieldView : UIView
//需要创建的cell个数
@property(nonatomic,assign)NSInteger cellCount;
//表名
@property(nonatomic,strong)NSString *sheetTitle;
@property(nonatomic,weak)id<DataAlterFieldViewDelegate>delegate;

//@property(nonatomic,strong)UITableView *tableView;

@end
