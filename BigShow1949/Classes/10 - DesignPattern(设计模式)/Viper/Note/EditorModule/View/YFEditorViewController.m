//
//  YFEditorViewController.m
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFEditorViewController.h"

#import "YFEditorViewDataSource.h"
#import "YFEditorViewEventHandler.h"

@interface YFEditorViewController ()
@property (nonatomic, strong) id<YFEditorViewEventHandler> eventHandler;
@property (nonatomic, strong) id<YFEditorViewDataSource> viewDataSource;

@property (nonatomic, strong) UITextField *titleTextField;

@end

@implementation YFEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
    [self setupUI];
    
    // 这里不识别 respondsToSelector 方法
//    if ([self.eventHandler respondsToSelector:@selector(handleViewReady)]) {
//        [self.eventHandler handleViewReady];
//    }
    
    [self.eventHandler handleViewReady];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if ([self.eventHandler respondsToSelector:@selector(handleViewWillAppear:)]) {
//        [self.eventHandler handleViewWillAppear:animated];
//    }
    [self.eventHandler handleViewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.eventHandler handleViewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.eventHandler handleViewWillDisappear:animated];
}

#pragma mark - YFEditorViewProtocol
- (nullable NSString *)titleString {
    return self.titleTextField.text;
}
- (nullable NSString *)contentString {
    return @"";
}

- (void)updateTitleString:(NSString *)title {
    self.titleTextField.text = title;
}
- (void)updateContentString:(NSString *)content {}

#pragma mark - Private
- (void)setupNav {
    self.title = @"Editor";
    UIBarButtonItem *addNoteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.eventHandler action:@selector(didTouchNavigationBarDoneButton)];
    self.navigationItem.rightBarButtonItem = addNoteItem;
    
//    if ([self.eventHandler respondsToSelector:@selector(handleViewReady)]) {
//        [self.eventHandler handleViewReady];
//    }
}

- (void)setupUI {
    
    self.titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    self.titleTextField.placeholder = @"输入信息";
    self.titleTextField.layer.borderWidth = 1;
    self.titleTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:self.titleTextField];
}






@end
