//
//  YFJigsawViewController.m
//  Jigsaw
//
//  Created by apple on 16/8/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YFJigsawViewController.h"
#import "YFChessBoardView.h"

@interface YFJigsawViewController ()
@property (nonatomic, strong) YFChessBoardView *boardView;


@end

@implementation YFJigsawViewController

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    YFChessBoardView *boardView = [[YFChessBoardView alloc] initWithFrame:CGRectMake(0, 0, 280, 280)];;
    boardView.center = self.view.center;
    boardView.backgroundImage = [UIImage imageNamed:@"img1.jpg"];
    [self.view addSubview:boardView];
    self.boardView = boardView;
    
    //
    UIButton *breakBtn = [[UIButton alloc] init];
    breakBtn.frame = CGRectMake(30, CGRectGetMaxY(boardView.frame) + 20, 100, 44);
    [breakBtn setTitle:@"打 乱" forState:UIControlStateNormal];
    [breakBtn addTarget:self action:@selector(breakBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    breakBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:breakBtn];
    
    
    [self breakBtnClick:breakBtn];
}


- (void)breakBtnClick:(UIButton *)btn {

    [self.boardView randomBreak];
    
}
@end
