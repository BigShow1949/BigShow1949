//
//  YNPageHeaderScrollView.m
//  YNPageViewController
//
//  Created by ZYN on 2018/5/25.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "YNPageHeaderScrollView.h"

@interface YNPageHeaderScrollView () <UIScrollViewDelegate>

@end

@implementation YNPageHeaderScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    
}




@end
