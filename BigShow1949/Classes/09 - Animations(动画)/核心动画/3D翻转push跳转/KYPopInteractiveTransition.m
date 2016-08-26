//
//  KYPopInteractiveTransition.m
//  KYPushTransitionDemo
//
//  Created by Kitten Yang on 4/19/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "KYPopInteractiveTransition.h"

@implementation KYPopInteractiveTransition{
    UIViewController *presentedVC;
}


-(void)addPopGesture:(UIViewController *)viewController{

    presentedVC = viewController;
    UIScreenEdgePanGestureRecognizer *edgeGes = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgeGesPan:)];
    edgeGes.edges = UIRectEdgeLeft;
    [viewController.view addGestureRecognizer:edgeGes];

}

-(void)edgeGesPan:(UIScreenEdgePanGestureRecognizer *)edgeGes{
    CGFloat translation =[edgeGes translationInView:presentedVC.view].x;
    CGFloat percent = translation / (presentedVC.view.bounds.size.width/2);
    percent = MIN(0.99, MAX(0.0, percent));
    NSLog(@"%f",percent);
    
    switch (edgeGes.state) {
        case UIGestureRecognizerStateBegan:{
            self.interacting =  YES;
//            [presentedVC dismissViewControllerAnimated:YES completion:nil];
//            如果是navigationController控制，这里应该是
            [presentedVC.navigationController popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged:{
        
            [self updateInteractiveTransition:percent];
            break;
        }

        case UIGestureRecognizerStateEnded:{

            self.interacting = NO;
            if (percent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
        }
            
        default:
            break;
    }
}


@end
