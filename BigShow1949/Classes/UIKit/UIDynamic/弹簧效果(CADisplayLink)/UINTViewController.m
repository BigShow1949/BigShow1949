//
//  UINTViewController.m
//  InteractiveAnimations
//
//  Created by Chris Eidhof on 02.05.14.
//  Copyright (c) 2014 Unsigned Integer. All rights reserved.
//

#import "UINTViewController.h"
#import "DraggableView.h"
#import "UINTSpringAnimation.h"

typedef NS_ENUM(NSInteger, PaneState) {
    PaneStateOpen,
    PaneStateClosed,
};

@interface UINTViewController () <DraggableViewDelegate>

@property (nonatomic) PaneState paneState;
@property (nonatomic, strong) DraggableView *pane;
@property (nonatomic) UINTSpringAnimation *springAnimation;
@end

@implementation UINTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize size = self.view.bounds.size;
    self.paneState = PaneStateClosed;
    DraggableView *view = [[DraggableView alloc] initWithFrame:CGRectMake(0, size.height * .75, size.width, size.height)];
    view.backgroundColor = [UIColor grayColor];
    view.delegate = self;
    [self.view addSubview:view];
    self.pane = view;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (CGPoint)targetPoint
{
    CGSize size = self.view.bounds.size;
    CGPoint targetPoint = self.paneState == PaneStateClosed > 0 ? CGPointMake(size.width/2, size.height * 1.25) : CGPointMake(size.width/2, size.height/2 + 100);
    return targetPoint;
}

- (void)startAnimatingView:(DraggableView *)view initialVelocity:(CGPoint)initialVelocity
{
    [self cancelSpringAnimation];
    self.springAnimation = [UINTSpringAnimation animationWithView:view target:self.targetPoint velocity:initialVelocity];
    [view.animator addAnimation:self.springAnimation];
}

- (void)cancelSpringAnimation
{
    [self.view.animator removeAnimation:self.springAnimation];
    self.springAnimation = nil;
}


#pragma mark DraggableViewDelegate

- (void)draggableView:(DraggableView *)view draggingEndedWithVelocity:(CGPoint)velocity
{
    PaneState targetState = velocity.y >= 0 ? PaneStateClosed : PaneStateOpen;
    self.paneState = targetState;
    [self startAnimatingView:view initialVelocity:velocity];
}

- (void)draggableViewBeganDragging:(DraggableView *)view
{
    [self cancelSpringAnimation];
}


#pragma mark Actions

- (void)didTap:(UITapGestureRecognizer *)tapRecognizer
{
    PaneState targetState = self.paneState == PaneStateOpen ? PaneStateClosed : PaneStateOpen;
    self.paneState = targetState;
    [self startAnimatingView:self.pane initialVelocity:self.springAnimation.velocity];
}

@end
