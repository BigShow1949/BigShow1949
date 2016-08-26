//
//  YFSlidingViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/3/17.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFSlidingViewController.h"
#import "LTSlidingViewCoverflowTransition.h"
#import "LTSlidingViewZoomTransition.h"

@implementation YFSlidingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.animator = [LTSlidingViewCoverflowTransition new];
    //    self.animator = [LTSlidingViewZoomTransition new];
    
    UIViewController *vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc"];
    UIViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc"];
    UIViewController *vc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc"];
    
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    [self addChildViewController:vc3];
    
}



- (void)didScrollToPage:(NSInteger)page
{
    NSLog(@"did scroll to page:%ld", (long)page);
}
@end
