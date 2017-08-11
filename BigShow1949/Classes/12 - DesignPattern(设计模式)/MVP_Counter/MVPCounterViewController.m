//
//  MVPCounterViewController.m
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "MVPCounterViewController.h"
#import "CounterRepository.h"
#import "CounterPresenter.h"


@interface MVPCounterViewController ()<CounterViewProtocol>
{
    CounterPresenter *_presenter;
    UILabel *_valueLabel;
}
@end

@implementation MVPCounterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    
    CounterRepository *counterRepository = [[CounterRepository alloc] init];
    _presenter = [[CounterPresenter alloc] initWithRepository:counterRepository inView:self];
    [_presenter getCurrentValue];
}

- (void)setupUI {
    
    UIButton *incrementBtn = [[UIButton alloc] init];
    incrementBtn.frame = CGRectMake(100, 100, 100, 100);
    [incrementBtn setTitle:@"加 数" forState:UIControlStateNormal];
    [incrementBtn addTarget:self action:@selector(incrementBtnClick) forControlEvents:UIControlEventTouchUpInside];
    incrementBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:incrementBtn];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 250, 100, 30)];
    countLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:countLabel];
    _valueLabel = countLabel;
    
    UIButton *decrementBtn = [[UIButton alloc] init];
    decrementBtn.frame = CGRectMake(100, 350, 100, 100);
    [decrementBtn setTitle:@"减 数" forState:UIControlStateNormal];
    [decrementBtn addTarget:self action:@selector(decrementBtnClick) forControlEvents:UIControlEventTouchUpInside];
    decrementBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:decrementBtn];
}

#pragma mark - Actions
- (void)incrementBtnClick {
    [_presenter incrementCounter];
}

- (void)decrementBtnClick {
    [_presenter decrementCounter];
}


#pragma mark - CounterViewProtocol Methods
- (void)updateCounterValue:(NSString*)value {
    _valueLabel.text = value;
}



@end
