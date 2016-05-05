//
//  YFAnimationVC04.m
//  BigShow1949
//
//  Created by WangMengqi on 15/9/2.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

#import "YFAnimationVC04.h"

@interface YFAnimationVC04 ()
@property (nonatomic, strong) YFRadialMenu *radialView;
@end

@implementation YFAnimationVC04

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    

}

-(void) viewWillAppear:(BOOL)animated {
    

}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    YFRadialMenu *radialView = [[YFRadialMenu alloc] initWithFrame:CGRectMake(self.view.center.x-25, self.view.frame.size.height - 120, 50, 50)];
    radialView.delegate = self;
    radialView.centerView.backgroundColor = [UIColor grayColor];
    [radialView addPopoutView:nil withIndentifier:@"ONE"];
    [radialView addPopoutView:nil withIndentifier:@"TWO"];
    [radialView addPopoutView:nil withIndentifier:@"THREE"];
    [radialView addPopoutView:nil withIndentifier:@"FOUR"];
    self.radialView = radialView;
    
    [self.view addSubview:radialView];
    [radialView enableDevelopmentMode:self];
}


- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

    [self.radialView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)radialMenu:(YFRadialMenu *)radialMenu didSelectPopoutWithIndentifier:(NSString *)identifier{
    NSLog(@"%@",identifier);
    
    
}

@end
