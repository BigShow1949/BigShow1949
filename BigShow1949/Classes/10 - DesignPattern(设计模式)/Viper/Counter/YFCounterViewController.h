//
//  YFETtstViewController.h
//  BigShow1949
//
//  Created by big show on 2018/10/15.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YFCounterPresenter;
@interface YFCounterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *decrementButton;
@property (weak, nonatomic) IBOutlet UIButton *incrementButton;

@property (nonatomic, strong) YFCounterPresenter *presenter;

@end
