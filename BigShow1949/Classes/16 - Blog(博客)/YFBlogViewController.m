//
//  YFAuthorBlogViewController.m
//  BigShow1949
//
//  Created by WangMengqi on 15/9/2.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

#import "YFBlogViewController.h"

@interface YFBlogViewController () {
    NSIndexPath             *_indexPath;
    NSArray *_dataArr;
}
@end

@implementation YFBlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = @[@[@"唐巧",@"http://blog.devtang.com/blog/archives/"],
                 @[@"王巍",@"http://www.onevcat.com"],
                 @[@"文顶顶",@"http://www.cnblogs.com/wendingding/p/"],
                 @[@"池建强",@"http://macshuo.com"],
                 @[@"CocoaChina",@"http://www.cocoachina.com"],
                 @[@"Code4App",@"http://www.code4app.com"],
                 @[@"Git@OSC",@"http://git.oschina.net"],
                 @[@"开源中国社区",@"http://www.oschina.net/code/list"],
                 @[@"GitHub",@"https://github.com"],
                 @[@"苹果Library",@"https://developer.apple.com/library/mac/navigation/"],];
    
    
    [self setupDataArr:_dataArr];
    
    //添加长按手势
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGR.minimumPressDuration = 0.5;
    [self.tableView addGestureRecognizer:longPressGR];
}


-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        CGPoint point = [gesture locationInView:self.tableView];
        _indexPath = [self.tableView indexPathForRowAtPoint:point];
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        NSArray *itemArr = _dataArr[_indexPath.row];
        pasteboard.string = itemArr[1];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"链接复制完成"
                                                        message:pasteboard.string
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
}

@end
