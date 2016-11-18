//
//  GCDDispatchGroupViewController.m
//  BigShow1949
//
//  Created by apple on 16/11/18.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "GCDDispatchGroupViewController.h"

@interface GCDDispatchGroupViewController ()

@end

@implementation GCDDispatchGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     需求:需要请求3个不同接口, 等3个接口都执行完, 再执行下一步操作
     分析:使用Dispatch Group追加block到Global Group Queue,这些block如果全部执行完毕，就会执行Main Dispatch Queue中的结束处理的block
     */
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:0.5]; // 模拟网络延时
        NSLog(@"下载1");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:0.5]; // 模拟网络延时
        NSLog(@"下载2");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"下一步操作");
    });
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:0.5]; // 模拟网络延时
        NSLog(@"下载3");
    });
    NSLog(@"程序运行到这里了------");
}


@end
