//
//  RootViewController.h
//  MutableMenuTableView
//
//  Created by 张国庆 on 16/4/27.
//  Copyright © 2016年 zgq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuData.h"
#import "MenuItemCell.h"
#import "SecondViewController.h"


@interface RootViewController : UIViewController

@property (nonatomic,strong)NSIndexPath *myIndexPath;
@property (nonatomic,strong)MenuData *menuData;
@end
