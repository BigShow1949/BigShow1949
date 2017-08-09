//
//  JSViewController.m
//  BigShow1949
//
//  Created by apple on 17/7/28.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "JSViewController.h"

@implementation JSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupDataArr:@[@[@"JSCore",@"JSCoreViewController"],
                         @[@"JSBridge使用",@"WebViewJSBridgeVC"], // 还有点问题
                         ]];
    
}
@end
