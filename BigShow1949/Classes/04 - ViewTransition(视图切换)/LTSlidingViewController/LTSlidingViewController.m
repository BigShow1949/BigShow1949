//
//  LTSlidingViewController..m
//
//  Created by ltebean on 14/10/31.
//  Copyright (c) 2014 ltebean. All rights reserved.
//

#import "LTSlidingViewController.h"

@interface LTSlidingViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic) CGFloat beginOffset;
@property (nonatomic) NSInteger currentPage;
@end

@implementation LTSlidingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currentPage = 0;
}


- (UIScrollView*)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)addChildViewController:(UIViewController *)childController
{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    childController.view.frame = CGRectMake(width * self.childViewControllers.count, 0, width, height);
    [self.scrollView addSubview:childController.view];
    
    [super addChildViewController:childController];
    [childController didMoveToParentViewController:self];
    
    self.scrollView.contentSize = CGSizeMake(width * self.childViewControllers.count, height);
}

- (void)removeAllChildViewControllers
{
    [self.childViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = (UIViewController *)obj;
        [vc willMoveToParentViewController:nil];
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
        self.scrollView.contentSize = CGSizeMake(0, CGRectGetHeight(self.view.bounds));
    }];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    CGFloat offset = self.scrollView.contentOffset.x;
    
    CGFloat progress = MIN(1,fabs((offset - self.beginOffset)/pageWidth));
    
    UIViewController *sourceVC = self.childViewControllers[self.currentPage];
    UIView *sourceView = sourceVC.view;
    UIView *destView;
    
    SlideDirection direction = self.slideDirection;

    NSInteger nextPage = direction == SlideDirectionRight ? self.currentPage + 1 : self.currentPage - 1;
    if (nextPage >= 0 && nextPage < self.childViewControllers.count) {
        UIViewController *destinationVC = self.childViewControllers[nextPage];
        destView = destinationVC.view;
    }
    
    if (self.animator) {
        [self.animator updateSourceView:sourceView destinationView:destView withProgress:progress direction:direction];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.beginOffset = self.scrollView.contentOffset.x;
    self.currentPage = [self calculateCurrentPage];
}

- (NSInteger)calculateCurrentPage
{
    CGFloat pageWidth = CGRectGetWidth(self.view.bounds);
    return floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.currentPage = [self calculateCurrentPage];
    UIViewController *destinationVC = self.childViewControllers[self.currentPage];
    [self.animator updateSourceView:nil destinationView:destinationVC.view withProgress:1 direction:self.slideDirection];
    [self didScrollToPage:self.currentPage];
}

- (SlideDirection)slideDirection
{
    return self.scrollView.contentOffset.x > self.beginOffset ? SlideDirectionRight : SlideDirectionLeft;
}

- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated;
{
    CGFloat pageWidth = CGRectGetWidth(self.view.bounds);
    CGPoint offset = CGPointMake(pageWidth * page, 0);
    [self.scrollView setContentOffset:offset animated:animated];
}


- (void)didScrollToPage:(NSInteger)page
{

}
@end
