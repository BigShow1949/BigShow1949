//
//  YFAnimationVC03.m
//  BigShow1949
//
//  Created by WangMengqi on 15/9/1.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

#import "YFAnimationVC03.h"
#import "UPStackMenu.h"

@interface YFAnimationVC03 ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UPStackMenu *stack;
@end

@implementation YFAnimationVC03


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self segmentedClick];
}


- (void)segmentedClick {
    //    if(self.stack)
    //        [self.stack removeFromSuperview];
    
    //    NSUInteger index = sender ? [(UISegmentedControl*)sender selectedSegmentIndex] : 0;
    NSUInteger index = 0;
    switch (index) {
        case 0:
            [self.stack setAnimationType:UPStackMenuAnimationType_progressive];
            [self.stack setStackPosition:UPStackMenuStackPosition_up];
            [self.stack setOpenAnimationDuration:.4];
            [self.stack setCloseAnimationDuration:.4];
            [self.items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
                [item setLabelPosition:UPStackMenuItemLabelPosition_right];
                [item setLabelPosition:UPStackMenuItemLabelPosition_left];
            }];
            break;
        default:
            break;
    }
    
    [self setStackIconClosed:YES];
    
}

- (void)setStackIconClosed:(BOOL)closed {
    
    UIImageView *icon = [[self.contentView subviews] objectAtIndex:0];
    float angle = closed ? 0 : (M_PI * (135) / 180.0);
    [UIView animateWithDuration:0.3 animations:^{
        [icon.layer setAffineTransform:CGAffineTransformRotate(CGAffineTransformIdentity, angle)];
    }];
}


- (NSMutableArray *)items {
    
    if (!_items) {
        UPStackMenuItem *squareItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"square"] highlightedImage:nil title:@"Square"];
        UPStackMenuItem *circleItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"circle"] highlightedImage:nil title:@"Circle"];
        UPStackMenuItem *triangleItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"triangle"] highlightedImage:nil title:@"Triangle"];
        UPStackMenuItem *crossItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"cross"] highlightedImage:nil title:@"Cross"];
        _items = [[NSMutableArray alloc] initWithObjects:squareItem, circleItem, triangleItem, crossItem, nil];
        
        [_items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
            [item setTitleColor:[UIColor yellowColor]];
        }];
    }
    return _items;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_contentView  setBackgroundColor:[UIColor colorWithRed:112./255. green:47./255. blue:168./255. alpha:1.]];
        [_contentView .layer setCornerRadius:6];
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cross"]];
        [icon setContentMode:UIViewContentModeScaleAspectFit];
        [icon setFrame:CGRectInset(_contentView .frame, 10, 10)];
        [_contentView  addSubview:icon];
    }
    return _contentView;
}

- (UPStackMenu *)stack {
    
    if (!_stack) {
        _stack = [[UPStackMenu alloc] initWithContentView:self.contentView];
        [_stack setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 20)];
        //    [stack setDelegate:self];
        
        [_stack addItems:self.items];
        [self.view addSubview:self.stack];
        
    }
    return _stack;
}

- (UISegmentedControl *)segmentedControl {

    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"one", @"two", @"three"]];
        _segmentedControl.frame = CGRectMake(0, 0, 250, 35);
        _segmentedControl.center = CGPointMake(YFScreen.width / 2, 100);
        [_segmentedControl addTarget:self action:@selector(segmentedClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_segmentedControl];
    }
    return _segmentedControl;
}


@end
