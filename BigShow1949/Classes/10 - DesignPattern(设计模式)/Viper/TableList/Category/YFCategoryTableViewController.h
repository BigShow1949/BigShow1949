//
//  YFCategoryTableViewController.h
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFCategoryTableViewControllerProtocol.h"
@class YFCategoryTablePresenter;
@interface YFCategoryTableViewController : UITableViewController<YFCategoryTableViewControllerDelegate>
@property (nonatomic, strong) YFCategoryTablePresenter *presenter;

@end
