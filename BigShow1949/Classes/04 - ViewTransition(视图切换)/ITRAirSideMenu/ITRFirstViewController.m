//
//  ViewController.m
//  ITRAirSideMenu
//
//  Created by kirthi on 11/08/15.
//  Copyright (c) 2015 kirthi. All rights reserved.
//

#import "ITRFirstViewController.h"
#import "ITRAirSideMenu.h"
#import "AppDelegate.h"

@interface ITRFirstViewController ()

@end

@implementation ITRFirstViewController


+ (instancetype) controller{
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ITRFirstViewController class])];
    ITRFirstViewController *firstVC = [[ITRFirstViewController alloc] init];
    firstVC.view.backgroundColor = [UIColor lightGrayColor];
    return firstVC;
}

#pragma view lifecycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController)];
}

- (void) presentLeftMenuViewController{
    
    //show left menu with animation
//    ITRAirSideMenu *itrSideMenu = ((AppDelegate *)[UIApplication sharedApplication].delegate).itrAirSideMenu;
//    [itrSideMenu presentLeftMenuViewController];
        
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com