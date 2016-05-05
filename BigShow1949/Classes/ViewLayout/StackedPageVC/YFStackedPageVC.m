//
//  YFStackedPageVC.m
//  BigShow1949
//
//  Created by zhht01 on 16/3/16.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFStackedPageVC.h"
#import "SSStackedPageView.h"
#import "UIColor+CatColors.h"

@interface YFStackedPageVC () <SSStackedViewDelegate>

@property (nonatomic) IBOutlet SSStackedPageView *stackView;
@property (nonatomic) NSMutableArray *views;

@end

@implementation YFStackedPageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.stackView.delegate = self;
    self.stackView.pagesHaveShadows = YES;
    self.views = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        UIView *thisView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 100.f)];
        [self.views addObject:thisView];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SSStackedViewDelegate
// 设置当前页的序号
- (UIView *)stackView:(SSStackedPageView *)stackView pageForIndex:(NSInteger)index
{
    UIView *thisView = [stackView dequeueReusablePage];
    if (!thisView) {
        thisView = [self.views objectAtIndex:index];
        thisView.backgroundColor = [UIColor getRandomColor];
        thisView.layer.cornerRadius = 5;
        thisView.layer.masksToBounds = YES;
    }
    return thisView;
}

// 总页数
- (NSInteger)numberOfPagesForStackView:(SSStackedPageView *)stackView
{
    return [self.views count];
}

// 点击页面
- (void)stackView:(SSStackedPageView *)stackView selectedPageAtIndex:(NSInteger) index
{
    NSLog(@"selected page: %i",(int)index);
}


@end

