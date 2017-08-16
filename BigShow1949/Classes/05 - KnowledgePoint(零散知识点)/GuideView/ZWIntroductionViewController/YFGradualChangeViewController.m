//
//  YFGradualChangeViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/5/10.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFGradualChangeViewController.h"
#import "ZWIntroductionViewController.h"

@interface YFGradualChangeViewController ()
@property (nonatomic, strong) ZWIntroductionViewController *introductionView;

@end

@implementation YFGradualChangeViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // Added Introduction View Controller
    NSArray *coverImageNames = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt"];
    NSArray *backgroundImageNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
    
    self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames];
    
    // Example 1 : Simple
    //    self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:backgroundImageNames];
    
    // Example 2 : Custom Button
    //    UIButton *enterButton = [UIButton new];
    //    [enterButton setBackgroundImage:[UIImage imageNamed:@"bg_bar"] forState:UIControlStateNormal];
    //    self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames button:enterButton];
    [self.view addSubview:self.introductionView.view];
    
    __weak YFGradualChangeViewController *weakSelf = self;
    self.introductionView.didSelectedEnter = ^() {
        weakSelf.introductionView = nil;
    };
}
@end
