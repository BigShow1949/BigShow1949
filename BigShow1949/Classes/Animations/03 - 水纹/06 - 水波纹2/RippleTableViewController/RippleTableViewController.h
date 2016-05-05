//
//  RippleTableViewController.h
//  RippleTableViewController
//
//  Created by Denis Berton
//  Copyright (c) 2013 clooket.com. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "GLIRViewController.h"

@interface RippleTableViewController : GLIRViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@end
