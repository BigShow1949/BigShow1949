//
//  YFToDoViewController.h
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFToDoPresenterInterface.h"
#import "YFToDoViewControllerInterface.h"
@interface YFToDoViewController : UITableViewController<YFToDoViewControllerDelegate>
@property (nonatomic, weak) id<YFToDoPresenterDelegate> presenter;

@end
