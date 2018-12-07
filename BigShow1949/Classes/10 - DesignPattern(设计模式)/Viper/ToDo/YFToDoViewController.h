//
//  YFToDoViewController.h
//  BigShow1949
//
//  Created by big show on 2018/12/7.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFToDoPresenter.h"
#import "YFToDoProtocols.h"

@interface YFToDoViewController : UIViewController<ToDoViewProtocol, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, nullable) YFToDoPresenter *presenter;
@end
