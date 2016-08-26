//
//  DemoListViewController.h
//  MGJRequestManagerDemo
//
//  Created by limboy on 3/20/15.
//  Copyright (c) 2015 juangua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIViewController *(^ViewControllerHandler)();

@interface DemoListViewController : UIViewController

+ (void)registerWithTitle:(NSString *)title handler:(ViewControllerHandler)handler;

@end
