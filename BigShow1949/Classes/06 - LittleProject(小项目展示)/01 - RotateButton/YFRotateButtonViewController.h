//
//  YFRotateButtonViewController.h
//  BigShow1949
//
//  Created by WangMengqi on 15/9/2.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFRotateButtonViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *btn;

// 行走
- (IBAction)run:(id)sende;
// 缩放
- (IBAction)scale:(id)sender;
// 旋转
- (IBAction)rotate:(id)sender;

@end
