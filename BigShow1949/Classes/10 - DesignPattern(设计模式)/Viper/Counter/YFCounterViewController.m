//
//  YFETtstViewController.m
//  BigShow1949
//
//  Created by big show on 2018/10/15.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFCounterViewController.h"

#import "YFCounterPresenter.h"
#import "YFCounterInteractor.h"
@interface YFCounterViewController ()<YFCounterView>

@end

@implementation YFCounterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.countLabel.text = nil;

    // 应该在给控制器初始化时赋值，写在这里只是为了方便代码结构统一，方便测试
    YFCounterPresenter *presenter = [[YFCounterPresenter alloc] init];
    self.presenter = presenter;
    presenter.delegateView = self;
    // self-----strong-》presenter-----weak-〉delegateView----》self
    
    //         presenter----strong-》interactor----〉weak-》presenter
    YFCounterInteractor *interactor = [[YFCounterInteractor alloc] init];
    presenter.delegateInteractor = interactor; // delegateInteractor如果不用strong，interactor会马上释放
    interactor.output = presenter;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.presenter updateView];
}

- (IBAction)decrement:(id)sender {
    [self.presenter decrement];
}

- (IBAction)increment:(id)sender {
    [self.presenter increment];
}


#pragma mark - Count view
- (void)setCountText:(NSString *)countText {
    self.countLabel.text = countText;
}

- (void)setDecrementEnabled:(BOOL)enabled {
    self.decrementButton.enabled = enabled;
}


@end
