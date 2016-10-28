//
//  YFBaiduViewTransitionViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/3/17.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFBaiduViewTransitionViewController.h"
#import "TempViewController.h"

#define COLOR(R, G, B, A)  [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define  ScreenSize [UIScreen mainScreen].bounds.size

@interface YFBaiduViewTransitionViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIView *currentVisibleView;
    NSMutableArray *allViews;
    UIView *maskView;
//    UIView *tarBarView;
    UIView *tarBarToolView;
    CGFloat screenWidth;
    CGFloat screenHeight;
    NSArray *tableviewArr;
    UITableView *viewList;
    NSInteger currentViewIndex;
}

@property (nonatomic, strong) UIView *tarBarView;

@end

@implementation YFBaiduViewTransitionViewController

typedef enum
{
    ShowViewDirectionLeftToRight = 0,
    ShowViewDirectionRightToLeft = 1,
}ShowViewDirection;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initViews];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initData
{
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenHeight = [UIScreen mainScreen].bounds.size.height;
}

- (void)initViews
{
    TempViewController *rootViewController = [[TempViewController alloc] init];
    [self addChildViewController:rootViewController];
    [self.view setBackgroundColor:[UIColor blackColor]];
    currentVisibleView = rootViewController.view;
    [self.view addSubview:rootViewController.view];
    allViews = [[NSMutableArray alloc] init];
    [allViews addObject:rootViewController.view];
    [rootViewController setTitle:@"根视图控制器"];
    tableviewArr = [NSArray arrayWithObject:@"根视图控制器"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showViewControllerList:) name:@"showVCList" object:nil];
    currentViewIndex = 1;
    
    maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [maskView setBackgroundColor:[UIColor blackColor]];
    [maskView setAlpha:0];
    UITapGestureRecognizer *reAnGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reAnGRAction)];
    [maskView addGestureRecognizer:reAnGR];
    
    
    
    [viewList setBackgroundColor:[UIColor purpleColor]];
    [self.tarBarView addSubview:viewList];
    [viewList setDataSource:self];
    [viewList setDelegate:self];
    [viewList setShowsVerticalScrollIndicator:NO];
    [viewList setTransform: CGAffineTransformMakeRotation(-M_PI / 2)];
    [viewList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)addViewController
{
    TempViewController *subVC = [[TempViewController alloc] init];
    [self addChildViewController:subVC];
    [subVC setTitle:@"新建窗口"];
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:tableviewArr];
    [arr addObject:@"新建窗口"];
    tableviewArr = arr;
    
    [viewList beginUpdates];
    [viewList insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:arr.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    [viewList endUpdates];
    [viewList scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
    [allViews addObject:subVC.view];
    [self.view insertSubview:subVC.view belowSubview:maskView];
    
    [self showViewToScreen:currentVisibleView next:subVC.view direction:ShowViewDirectionRightToLeft currViewIndex:tableviewArr.count];
}

- (void)showViewControllerList:(NSNotification *)notification
{
    [self animateForView:currentVisibleView];
}

- (void)showViewToScreen:(UIView *)preView next:(UIView *)nextView direction:(ShowViewDirection)dir currViewIndex:(NSInteger)index
{
    CGRect showFrame = [UIScreen mainScreen].bounds;
    CGRect frameOfPreView = showFrame;
    CGRect frameOfNextView = showFrame;
    
    CGRect unVisibelFrame = showFrame;
    unVisibelFrame.origin.y += screenHeight;
    for (UIView *view in allViews) {
        if (view != preView && view != nextView) {
            [view setFrame:unVisibelFrame];
        }
    }
    if (dir == ShowViewDirectionRightToLeft) {
        frameOfPreView.origin.x = showFrame.origin.x - screenWidth;
        frameOfNextView.origin.x = showFrame.origin.x + screenWidth;
        [nextView setFrame:frameOfNextView];
        [nextView.layer setTransform:[self secondTransformWithView:nextView]];
    }else{
        frameOfPreView.origin.x = showFrame.origin.x + screenWidth;
        frameOfNextView.origin.x = showFrame.origin.x - screenWidth;
        [nextView setFrame:frameOfNextView];
        [nextView.layer setTransform:[self secondTransformWithView:nextView]];
    }
    [UIView animateWithDuration:0.35 animations:^{
        [preView setFrame:frameOfPreView];
        [nextView setFrame:showFrame];
    } completion:^(BOOL finished){
        currentVisibleView = nextView;
        currentViewIndex = index;
        [self reAnimateForView:currentVisibleView];
    }];
}

- (void)reAnGRAction
{
    [self reAnimateForView:currentVisibleView];
}

- (void)animateForView:(UIView *)view
{
    [self.view addSubview:maskView];
    CGRect frame = [self.tarBarView frame];
    frame.origin.y = screenHeight - 340;
    [UIView animateWithDuration:0.2f animations:^{
        [view.layer setTransform:[self firstTransform]];
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.2f animations:^{
            [view.layer setTransform:[self secondTransformWithView:view]];
        } completion:^(BOOL finished){
            [UIView animateWithDuration:0.2 animations:^{
                [maskView setAlpha:0.5f];
                [self.tarBarView setFrame:frame];
            }];
        }];
    }];
    [self.view bringSubviewToFront:self.tarBarView];
}

- (void)reAnimateForView:(UIView *)view
{
    CGRect frame = [self.tarBarView frame];
    frame.origin.y += 340;
    [UIView animateWithDuration:0.2f animations:^{
        [maskView setAlpha:0.f];
        [self.tarBarView setFrame:frame];
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.2f animations:^{
            [maskView removeFromSuperview];
            [view.layer setTransform:[self firstTransform]];
        } completion:^(BOOL finished){
            [UIView animateWithDuration:0.2f animations:^{
                [view.layer setTransform:CATransform3DIdentity];
            }];
        }];
    }];
}

-(CATransform3D)firstTransform{
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    t1 = CATransform3DRotate(t1, 15.0f * M_PI/180.0f, 1, 0, 0);
    return t1;
    
}

-(CATransform3D)secondTransformWithView:(UIView*)view{
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = [self firstTransform].m34;
    t2 = CATransform3DTranslate(t2, 0, view.frame.size.height*-0.08, 0);
    t2 = CATransform3DScale(t2, 0.8, 0.8, 1);
    return t2;
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableviewArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell.contentView setBackgroundColor:[UIColor greenColor]];
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, 140, screenWidth - 100)];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [imgV setBackgroundColor:[UIColor yellowColor]];
        [imgV setTag:2015];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 140, 20)];
        [titleLabel setText:@"标题"];
        [cell.contentView addSubview:titleLabel];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setTag:2016];
        [cell.contentView addSubview:imgV];
    }
    UILabel *label = (UILabel *)[cell viewWithTag:2016];
    NSString *title = (NSString *)[tableviewArr objectAtIndex:indexPath.row];
    [label setText:title];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = (UIView *)[allViews objectAtIndex:(indexPath.row)];
    NSInteger cmp = currentViewIndex - 1;
    NSInteger row = indexPath.row;
    if (row == cmp) {
        [self reAnGRAction];
        return;
    }
    if (row > cmp) {
        [self showViewToScreen:currentVisibleView next:view direction:ShowViewDirectionRightToLeft currViewIndex:indexPath.row+1];
    }else{
        [self showViewToScreen:currentVisibleView next:view direction:ShowViewDirectionLeftToRight currViewIndex:indexPath.row+1];
    }
}

#pragma mark - setter
- (UIView *)tarBarView {

    if (!_tarBarView) {
        _tarBarView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight, screenWidth, 340)];
        [_tarBarView setBackgroundColor:[UIColor whiteColor]];
        
        tarBarToolView = [[UIView alloc] initWithFrame:CGRectMake(0, 340 - 44, screenWidth, 44)];
        [tarBarToolView setBackgroundColor:COLOR(57, 107, 117, 1)];
        [_tarBarView addSubview:tarBarToolView];
        [self.view addSubview:_tarBarView];
        
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 12, 80, 20)];
        [addBtn setTitleColor:COLOR(231, 231, 231, 1) forState:UIControlStateNormal];
        [addBtn setTitleColor:COLOR(231, 231, 231, 1) forState:UIControlStateHighlighted];
        [addBtn setTitle:@"新建窗口" forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addViewController) forControlEvents:UIControlEventTouchUpInside];
        [tarBarToolView addSubview:addBtn];
        
        UIButton *finishBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - 50, 12, 40, 20)];
        [finishBtn setTitleColor:COLOR(231, 231, 231, 1) forState:UIControlStateNormal];
        [finishBtn setTitleColor:COLOR(231, 231, 231, 1) forState:UIControlStateHighlighted];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [finishBtn addTarget:self action:@selector(reAnGRAction) forControlEvents:UIControlEventTouchUpInside];
        [tarBarToolView addSubview:finishBtn];
        if (screenWidth == 320) {
            viewList = [[UITableView alloc] initWithFrame:CGRectMake(20, -10, 276, screenWidth)];
        }else if (screenWidth == 375) {
            viewList = [[UITableView alloc] initWithFrame:CGRectMake(50, -40, 276, screenWidth)];
        }else{
            viewList = [[UITableView alloc] initWithFrame:CGRectMake(70, -60, 276, screenWidth)];
        }

    }
    return _tarBarView;
}

@end
