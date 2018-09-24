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
    
//    [self test1];
    
    [self test2];

}

/*
 需求:下载3张图片, 等三张图片都下载完成再显示
 分析:使用Dispatch Group追加block到Global Group Queue,这些block如果全部执行完毕，就会执行Main Dispatch Queue中的结束处理的block
 */
- (void)test1 {

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
}


/*
 需求:需要请求3个不同接口, 等3个接口都执行完, 再显示界面, 然后再根据这个界面信息,请求网络
 （注意：使用 dispatch_barrier_async ，该函数只能搭配自定义并行队列 dispatch_queue_t 使用。不能使用： dispatch_get_global_queue ，否则 dispatch_barrier_async 的作用会和 dispatch_async 的作用一模一样。 ）
 */
- (void)test2 {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^(){
        [NSThread sleepForTimeInterval:0.6];
        NSLog(@"dispatch-1");
    });
    
    dispatch_async(concurrentQueue, ^(){
        [NSThread sleepForTimeInterval:0.8];
        NSLog(@"dispatch-2");
    });
    
    dispatch_barrier_async(concurrentQueue, ^(){
        NSLog(@"dispatch-barrier");
    });
    
    dispatch_async(concurrentQueue, ^(){
        [NSThread sleepForTimeInterval:0.5];
        
        NSLog(@"dispatch-3");
    });
    
    dispatch_async(concurrentQueue, ^(){
        [NSThread sleepForTimeInterval:0.5];
        
        NSLog(@"dispatch-4");
    });
}


@end
