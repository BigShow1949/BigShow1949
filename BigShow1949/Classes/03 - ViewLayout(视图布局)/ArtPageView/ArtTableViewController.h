//
//  ArtTableViewController.h
//  Demo
//
//  Created by weijingyun on 16/5/28.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtTableViewController : UIViewController

@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL allowPullToRefresh;
@property (nonatomic, assign) CGFloat pullOffset;
@property (nonatomic, assign) CGFloat fillHight;  //segmentButtons + segmentTopSpace

@end
