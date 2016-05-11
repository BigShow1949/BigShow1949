//
//  YFITRAirSideViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/5/11.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFITRAirSideViewController.h"

#import "ITRFirstViewController.h"
#import "ITRLeftMenuController.h"

@implementation YFITRAirSideViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"点我啊" forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

- (void)btnClick {
    //sidemenu created with content view controller & menu view controller
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[ITRFirstViewController controller]];
    ITRLeftMenuController *leftMenuViewController = [ITRLeftMenuController controller];
    _itrAirSideMenu = [[ITRAirSideMenu alloc] initWithContentViewController:navigationController leftMenuViewController:leftMenuViewController];
    
    _itrAirSideMenu.backgroundImage = [UIImage imageNamed:@"menu_bg.jpg"];
    
    //optional delegate to receive menu view status
    _itrAirSideMenu.delegate = leftMenuViewController;
    
    //content view shadow properties
    _itrAirSideMenu.contentViewShadowColor = [UIColor blackColor];
    _itrAirSideMenu.contentViewShadowOffset = CGSizeMake(0, 0);
    _itrAirSideMenu.contentViewShadowOpacity = 0.6;
    _itrAirSideMenu.contentViewShadowRadius = 12;
    _itrAirSideMenu.contentViewShadowEnabled = YES;
    
    //content view animation properties
    _itrAirSideMenu.contentViewScaleValue = 0.7f;
    _itrAirSideMenu.contentViewRotatingAngle = 30.0f;
    _itrAirSideMenu.contentViewTranslateX = 130.0f;
    
    //menu view properties
    _itrAirSideMenu.menuViewRotatingAngle = 30.0f;
    _itrAirSideMenu.menuViewTranslateX = 130.0f;

    [self presentViewController:_itrAirSideMenu animated:NO completion:nil];

}


@end
