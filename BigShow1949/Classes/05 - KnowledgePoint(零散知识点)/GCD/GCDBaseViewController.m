//
//  GCDBaseViewController.m
//  BigShow1949
//
//  Created by big show on 2018/7/24.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "GCDBaseViewController.h"
/*
 
 基础概念：
 线程:线程是进程中一个独立的执行路径(控制单元);一个进程中至少包含一条线程，即主线程
 
 队列：是来管理线程的，线程里面放着很多的任务，来管理这些任务什么时候在哪些线程里去执行。
 串行队列：队列中的任务只会顺序执行(类似跑步)
 　　　　dispatch_queue_t q = dispatch_queue_create(“....”, DISPATCH_QUEUE_SERIAL);
 并行队列：队列中的任务通常会并发执行(类似赛跑)
 　　　　dispatch_queue_t q = dispatch_queue_create("......", DISPATCH_QUEUE_CONCURRENT);
 全局队列：是系统的，直接拿过来（GET）用就可以；与并行队列类似，但调试时，无法确认操作所在队列
 dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 主队列：每一个应用程序对应唯一一个主队列，直接GET即可；在多线程开发中，使用主队列更新UI
 dispatch_queue_t q = dispatch_get_main_queue();
 
 
 操作
 　　dispatch_async 异步操作，会并发执行，无法确定任务的执行顺序；
 dispatch_sync 同步操作，会依次顺序执行，能够决定任务的执行顺序；
 区别：
 同步任务优先级高，在线程中有执行顺序，不会开启新的线程。
 异步任务优先级低，在线程中执行没有顺序，看cpu闲不闲。在主队列中不会开启新的线程，其他队列会开启新的线程。
 
 串行队列同步：操作顺序执行；都在主线程，不会开启新线程
 串行队列异步：操作需要一个子线程，会新建线程、线程的创建和回收不需要程序员参与，操作顺序执行，“最安全的选择”
 
 并行队列同步：操作顺序执行；都在主线程，不会开启新线程
 并行队列异步：操作会新建多个线程（有多少任务，就开N个线程执行）、操作无序执行；队列前如果有其他任务，会等待前面的任务完成之后再执行；场景：既不影响主线程，又不需要顺序执行的操作！
 
 全局队列异步：操作会新建多个线程、操作无序执行，队列前如果有其他任务，会等待前面的任务完成之后再执行
 全局队列同步：操作不会新建线程、操作顺序执行
 
 主队列异步：它没有阻塞主线程，因为异步任务的优先级低，不会抢占主线程的执行资源，只有cpu出现空闲时才会去执行它。操作都应该在主线程上顺序执行的，不存在异步的概念
 主队列同步：因为在主队列开启同步任务时，主队列是串行队列，里面的线程是有顺序的，先执行完一个线程才执行下一个线程。而主队列始终就只有一个主线程，主线程还是无限循环的，是不会执行完毕的，除非关闭应用程序。因此在主线程开启一个同步任务，同步任务会想抢占执行的资源，而主线程任务一直在执行某些操作，不肯放手。两个的优先级都很高，最终导致死锁，阻塞线程了。
 
 */
@interface GCDBaseViewController ()

@end

@implementation GCDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 200, 400)];
    label.text = @"具体内容直接看代码";
    [self.view addSubview:label];
    
    [self demo8];
}

#pragma mark - 队列&同异步
- (void)demo1 { // 主队列同步：会死锁
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"主线程队列创建一个同步任务");
    });
}
- (void)demo2 { // 主队列异步
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"这是我在主线程队列创建的异步任务");
        NSLog(@"是否主线程：%d",[NSThread isMainThread]); // 1:是在主线程中
    });
}
- (void)demo3 { // 串行队列异步：会开启一个子线程；顺序执行
    dispatch_queue_t queue = dispatch_queue_create("hmj", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        NSLog(@"我是第一个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"我是第二个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"我是第三个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"我是第四个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    /*
     2016-05-27 19:52:01.012 多线程GCDTest[30425:575429] 我是第一个任务, 当前线程:<NSThread: 0x7fb370d1ad60>{number = 3, name = (null)} ,是否主线程0
     2016-05-27 19:52:01.012 多线程GCDTest[30425:575429] 我是第二个任务, 当前线程:<NSThread: 0x7fb370d1ad60>{number = 3, name = (null)} ,是否主线程0
     2016-05-27 19:52:01.012 多线程GCDTest[30425:575429] 我是第三个任务, 当前线程:<NSThread: 0x7fb370d1ad60>{number = 3, name = (null)} ,是否主线程0
     2016-05-27 19:52:01.013 多线程GCDTest[30425:575429] 我是第四个任务, 当前线程:<NSThread: 0x7fb370d1ad60>{number = 3, name = (null)} ,是否主线程0
     */
}
- (void)demo4 { // 并行队列异步：顺序不固定（几乎同时打印，只是cup执行的太快）；每个任务都在一个子线程中
    dispatch_queue_t queue = dispatch_queue_create("hmj", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"我是第一个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"我是第二个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"我是第三个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"我是第四个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    
/*
 018-07-24 22:42:30.189752+0700 BigShow[64518:5519578] 我是第一个任务, 当前线程:<NSThread: 0x600000460700>{number = 4, name = (null)} ,是否主线程0
 2018-07-24 22:42:30.189755+0700 BigShow[64518:5519585] 我是第二个任务, 当前线程:<NSThread: 0x60c00047c600>{number = 3, name = (null)} ,是否主线程0
 2018-07-24 22:42:30.189777+0700 BigShow[64518:5519584] 我是第四个任务, 当前线程:<NSThread: 0x608000270c40>{number = 6, name = (null)} ,是否主线程0
 2018-07-24 22:42:30.189782+0700 BigShow[64518:5519583] 我是第三个任务, 当前线程:<NSThread: 0x604000265640>{number = 5, name = (null)} ,是否主线程0
 */
}

- (void)demo5 { // 串行队列同步：顺序执行；都在主线程
    dispatch_queue_t queue = dispatch_queue_create("hmj", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        NSLog(@"我是第一个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"我是第二个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"我是第三个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"我是第四个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    /*
 2018-07-24 22:53:13.343081+0700 BigShow[64737:5533013] 我是第一个任务, 当前线程:<NSThread: 0x60400007ad80>{number = 1, name = main} ,是否主线程1
 2018-07-24 22:53:13.343308+0700 BigShow[64737:5533013] 我是第二个任务, 当前线程:<NSThread: 0x60400007ad80>{number = 1, name = main} ,是否主线程1
 2018-07-24 22:53:13.343470+0700 BigShow[64737:5533013] 我是第三个任务, 当前线程:<NSThread: 0x60400007ad80>{number = 1, name = main} ,是否主线程1
 2018-07-24 22:53:13.343627+0700 BigShow[64737:5533013] 我是第四个任务, 当前线程:<NSThread: 0x60400007ad80>{number = 1, name = main} ,是否主线程1
     */
}
- (void)demo6 { // 并行队列同步：顺序执行；都在主线程
    dispatch_queue_t queue = dispatch_queue_create("hmj", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"我是第一个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"我是第二个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"我是第三个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"我是第四个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    
    /*
 2018-07-24 22:53:59.145025+0700 BigShow[64837:5534781] 我是第一个任务, 当前线程:<NSThread: 0x60c00007e440>{number = 1, name = main} ,是否主线程1
 2018-07-24 22:54:00.145592+0700 BigShow[64837:5534781] 我是第二个任务, 当前线程:<NSThread: 0x60c00007e440>{number = 1, name = main} ,是否主线程1
 2018-07-24 22:54:01.146278+0700 BigShow[64837:5534781] 我是第三个任务, 当前线程:<NSThread: 0x60c00007e440>{number = 1, name = main} ,是否主线程1
 2018-07-24 22:54:02.146797+0700 BigShow[64837:5534781] 我是第四个任务, 当前线程:<NSThread: 0x60c00007e440>{number = 1, name = main} ,是否主线程1
     */
}

#pragma mark - 场景应用
- (void)demo7 { // 场景：子线程处理耗时操作，然后主线程刷新
    dispatch_async(dispatch_get_global_queue(0,0),^{
        
        NSLog(@"Start task 1");
        
        [NSThread sleepForTimeInterval:3];
        
        dispatch_async(dispatch_get_main_queue(),^{
            //回到主线程刷新UI
            NSLog(@"刷新UI");
        });
        
    });
}

- (void)demo8 {  // 系统分配子线程应用
    /*
     #define DISPATCH_QUEUE_PRIORITY_HIGH 2
     #define DISPATCH_QUEUE_PRIORITY_DEFAULT 0
     #define DISPATCH_QUEUE_PRIORITY_LOW (-2)
     #define DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"start task 1");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end task 1");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"start task 2");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end task 2");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSLog(@"start task 3");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end task 3");
    });
    /*
 2018-07-24 23:57:58.425683+0700 BigShow[65432:5588174] start task 3
 2018-07-24 23:57:58.425649+0700 BigShow[65432:5587757] start task 1
 2018-07-24 23:57:58.425686+0700 BigShow[65432:5588184] start task 2
 2018-07-24 23:58:00.425994+0700 BigShow[65432:5588184] end task 2
 2018-07-24 23:58:00.426004+0700 BigShow[65432:5587757] end task 1
 2018-07-24 23:58:00.426005+0700 BigShow[65432:5588174] end task 3
     
     2018-07-24 23:58:36.530524+0700 BigShow[65531:5589495] start task 3
     2018-07-24 23:58:36.530524+0700 BigShow[65531:5589459] start task 1
     2018-07-24 23:58:36.530536+0700 BigShow[65531:5589476] start task 2
     2018-07-24 23:58:38.535998+0700 BigShow[65531:5589459] end task 1
     2018-07-24 23:58:38.536031+0700 BigShow[65531:5589476] end task 2
     2018-07-24 23:58:38.606652+0700 BigShow[65531:5589495] end task 3
     
     2018-07-25 00:03:31.901008+0700 BigShow[65531:5595700] start task 1
     2018-07-25 00:03:31.901045+0700 BigShow[65531:5595731] start task 2
     2018-07-25 00:03:31.900987+0700 BigShow[65531:5589458] start task 3
     2018-07-25 00:03:33.901304+0700 BigShow[65531:5595700] end task 1
     2018-07-25 00:03:33.901315+0700 BigShow[65531:5595731] end task 2
     2018-07-25 00:03:34.000112+0700 BigShow[65531:5589458] end task 3
     */
}

/*
 参考链接：
 https://www.jianshu.com/p/a285361a2085
 https://www.cnblogs.com/yjg2014/p/yjg.html
 */
@end
