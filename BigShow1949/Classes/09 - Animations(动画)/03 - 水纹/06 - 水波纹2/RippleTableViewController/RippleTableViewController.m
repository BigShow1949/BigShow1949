//
//  RippleTableViewController.m
//  RippleTableViewController
//
//  Created by Denis Berton
//  Copyright (c) 2013 clooket.com. All rights reserved.
//


#import "RippleTableViewController.h"


@interface RippleTableViewController ()<UIGestureRecognizerDelegate>
@end

@implementation RippleTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizesSubviews = YES;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIPanGestureRecognizer  *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGestureRecognizer.enabled = YES;
    panGestureRecognizer.cancelsTouchesInView = NO;
    panGestureRecognizer.delegate = self;
    [self.tableView addGestureRecognizer:panGestureRecognizer];
    
    UITapGestureRecognizer  *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    singleTapGestureRecognizer.enabled = YES;
    singleTapGestureRecognizer.cancelsTouchesInView = NO;
    singleTapGestureRecognizer.delegate = self;
    [self.tableView addGestureRecognizer:singleTapGestureRecognizer];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self cleanRipple];    
    stopUdpate = NO;
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    stopUdpate = YES;
//    [self cleanRipple];
}

- (void)handlePanGesture:(UITapGestureRecognizer *)gesture {
  CGPoint location = [gesture locationInView:nil];
//  [_ripple initiateRippleAtLocation:location];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //avoid UIKit freeze
    [self render:displayLink];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


@end


