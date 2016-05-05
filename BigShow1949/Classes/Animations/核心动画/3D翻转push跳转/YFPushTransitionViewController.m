//
//  YFPushTransitionViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/1/22.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFPushTransitionViewController.h"
#import "YFSecondPushViewController.h"

#import "KYPushTransition.h"
#import "KYPopTransition.h"
#import "KYPopInteractiveTransition.h"

@interface YFPushTransitionViewController (){

    KYPopInteractiveTransition *popInteractive;

}

@end

@implementation YFPushTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [nextBtn setTitle:@"下一个" forState:UIControlStateNormal];
    nextBtn.backgroundColor = [UIColor redColor];
    [nextBtn addTarget:self action:@selector(text) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];

    self.navigationController.delegate = self;
}

- (void)text {

    YFSecondPushViewController *secondVC = [[YFSecondPushViewController alloc] init];
    self.transitioningDelegate = self;
    popInteractive = [KYPopInteractiveTransition new];
    [popInteractive addPopGesture:secondVC];
    [self.navigationController pushViewController:secondVC animated:YES];
}

#pragma mark -- UINavigationController 控制两个VC的情况下

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        
        KYPushTransition *flip = [KYPushTransition new];
        return flip;
        
    }else if (operation == UINavigationControllerOperationPop){
        
        KYPopTransition *flip = [KYPopTransition new];
        return flip;
        
    }else{
        return nil;
    }
}


- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    return popInteractive.interacting ? popInteractive : nil;
}


//#pragma mark -- 直接两个VC之间的present和dismiss的情况下
//- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
//
//    KYPushTransition *flip = [KYPushTransition new];
//
//    return flip;
//}
//
//- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
//    KYPopTransition *flip = [KYPopTransition new];
//    return flip;
//
//}
//
//
//- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
//    return popInteractive.interacting ? popInteractive : nil;
//
//}


@end
