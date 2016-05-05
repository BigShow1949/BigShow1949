//
//  DataEditView.h
//  BigShow1949
//
//  Created by zhht01 on 16/4/22.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DataEditViewDelegate <NSObject>


//确定成功
- (void)ensureAction:(NSArray *)dataArray;
//关闭
- (void)closeAction;

@end

@interface DataEditView : UIView<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,weak)id<DataEditViewDelegate>delegate;

@property(nonatomic,strong)UITableView *tableView;


@property (nonatomic, strong) NSArray *placeholders; // cell 的 placeholder(必须要赋值)

@property (nonatomic, strong) NSArray *texts; // cell 的text(可能为空)



@end
