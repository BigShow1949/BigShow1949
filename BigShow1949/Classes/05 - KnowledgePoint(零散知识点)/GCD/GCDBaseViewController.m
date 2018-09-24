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
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 200, 400)];
//    label.text = @"具体内容直接看代码";
//    [self.view addSubview:label];
//
    [self demo16];
    
    
    
    CGFloat maxY = 100;
    for (int i = 1; i < 17; i++) {
        NSLog(@"i = %d", i);
        NSString *mySelStr = [NSString stringWithFormat:@"demo%d", i];
        SEL mySEL = NSSelectorFromString(mySelStr);
        CGFloat btnY = maxY;
        CGFloat btnX = 100;
        if (i%2 == 0) {
            btnX = 100 + 80 + 10;
        }
        UIButton *redBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, 80, 44)];
        [redBtn setTitle:mySelStr forState:UIControlStateNormal];
        [redBtn addTarget:self action:mySEL forControlEvents:UIControlEventTouchUpInside];
        redBtn.titleLabel.textColor = [UIColor blackColor];
        redBtn.backgroundColor = [UIColor blueColor];
        [self.view addSubview:redBtn];
        
        if (i%2 == 0) {
            maxY = CGRectGetMaxY(redBtn.frame);
        }
        
    }
    
    
    

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
        NSLog(@"我是第一个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end task 1");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"start task 2");
        NSLog(@"我是第二个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end task 2");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSLog(@"start task 3");
        NSLog(@"我是第三个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
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

- (void)demo9 { // 自行创建子线程
    dispatch_queue_t queue = dispatch_queue_create("com.test.gcg.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"start task 1");
        NSLog(@"我是第一个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end task 1");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"start task 2");
        NSLog(@"我是第二个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end task 2");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"start task 3");
        NSLog(@"我是第三个任务, 当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end task 3");
    });
}

- (void)demo10 {  // 多个网络请求完，执行下一步（一般做法异步是实现不了的）
    NSString *str = @"https://www.jianshu.com/";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];

    for (int i=0; i<10; i++) {
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"%d---%d",i,i);
        }];
        [task resume];
    }
    NSLog(@"end");
    
//    dispatch_queue_t queue1 = dispatch_queue_create("com.test.gcg.group", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_async(group, queue1, ^{
//        NSLog(@"start task 1");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 1");
//    });
//    dispatch_group_async(group, queue1, ^{
//        NSLog(@"start task 2");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 2");
//    });
//    dispatch_group_async(group, queue1, ^{
//        NSLog(@"start task 3");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 3");
//    });
//
//    NSLog(@"====end");
}

- (void)demo11 { // 多个网络请求完，执行下一步 dispatch_group_t实现
    NSLog(@"============================ demo11");

    /*
     线程组:
         dispatch_group_notify；
         dispatch_group_enter(group);
         dispatch_group_leave(group);
     注意事项：使用线程组的方法来创建任务是没有同步任务的，
     */
    dispatch_queue_t queue1 = dispatch_queue_create("com.test.gcg.group", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_enter(group);
    [self sendRequest1:^{
        NSLog(@"request1 done");
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self sendRequest2:^{
        NSLog(@"request2 done");
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, queue1, ^{
        NSLog(@"All tasks over");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程刷新UI");
        });
    });
}

-(void)sendRequest1:(void(^)())block{
    
    dispatch_async(dispatch_get_global_queue(0,0),^{
        
        NSLog(@"start task 1");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end task 1");
        dispatch_async(dispatch_get_main_queue(),^{
            if(block){
                block();
            }
        });
    });
    
}
-(void)sendRequest2:(void(^)())block{
    
    dispatch_async(dispatch_get_global_queue(0,0),^{
        
        NSLog(@"start task 2");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"end task 2");
        dispatch_async(dispatch_get_main_queue(),^{
            if(block){
                block();
            }
        });
    });
}
- (void)demo12 { // 多个网络请求完，执行下一步 GCD的信号量 dispatch_semaphore_t实现
    NSLog(@"============================ demo12");

    NSString *str = @"https://www.jianshu.com";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 如果semaphore计数大于等于1，计数-1，返回，程序继续运行。如果计数为0，则等待。
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    __block NSInteger count = 0;
    for (int i=0; i<10; i++) {
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"%d---%d",i,i);
            count++;
            if (count==10) {
                dispatch_semaphore_signal(sem); // 回调10次之后再发信号量，使后面程序继续运行
                count = 0;
            }
        }];
        [task resume];
    }
    // 如果计数为0，则等待
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER); // 等待时间DISPATCH_TIME_FOREVER 等到永远
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
    
    /*
     2018-07-25 14:37:56.508104+0700 BigShow[70482:5837307] 0---0
     2018-07-25 14:37:56.570436+0700 BigShow[70482:5837307] 3---3
     2018-07-25 14:37:56.644082+0700 BigShow[70482:5837308] 1---1
     2018-07-25 14:37:56.700738+0700 BigShow[70482:5837307] 2---2
     2018-07-25 14:37:56.722227+0700 BigShow[70482:5837308] 4---4
     2018-07-25 14:37:56.810692+0700 BigShow[70482:5837307] 5---5
     2018-07-25 14:37:56.871034+0700 BigShow[70482:5837321] 6---6
     2018-07-25 14:37:56.929290+0700 BigShow[70482:5837494] 7---7
     2018-07-25 14:37:57.013721+0700 BigShow[70482:5837308] 9---9
     2018-07-25 14:37:57.133674+0700 BigShow[70482:5837321] 8---8
     2018-07-25 14:37:57.148330+0700 BigShow[70482:5837246] end
     */
}

// Q：移到项目中后，不是顺序执行了？也是在主线程中执行，WHY？看到此问题的各路大神，求解答！！3q！
- (void)demo13 { // 在上面的基础上，要10个网络请求顺序回调（end先执行了，看demo14解决）
    NSLog(@"当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);
    NSLog(@"============================ demo13");
    NSString *str = @"http://www.jianshu.com/p/6930f335adba";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableArray *operationArr = [[NSMutableArray alloc]init];
    for (int i=0; i<10; i++) {
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"当前线程:%@ ,是否主线程%d",[NSThread currentThread],[NSThread isMainThread]);

            NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    NSLog(@"%d---%d",i,i);
                }];
            [task resume];
            //非网络请求
            NSLog(@"noRequest-%d",i);
        }];
        
        [operationArr addObject:operation];
        if (i>0) {
            NSBlockOperation *operation1 = operationArr[i-1];
            NSBlockOperation *operation2 = operationArr[i];
            [operation2 addDependency:operation1];
        }
    }
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 10;
    [queue addOperations:operationArr waitUntilFinished:NO];  //YES会阻塞当前线程
#warning - 绝对不要在应用主线程中等待一个Operation,只能在第二或次要线程中等待。阻塞主线程将导致应用无法响应用户事件,应用也将表现为无响应。
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
}

- (void)demo14 { // 解决demo13的问题：用信号量semaphore解决
    NSLog(@"============================ demo14");

    NSString *str = @"http://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=%E5%9B%BE%E7%89%87&hs=0&pn=3&spn=0&di=28292004620&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&ie=utf-8&oe=utf-8&cl=2&lm=-1&cs=2506796592%2C812786931&os=769236739%2C175852528&simid=0%2C0&adpicid=0&lpn=0&ln=30&fr=ala&fm=&sme=&cg=&bdtype=0&oriquery=&objurl=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01c60259ac0f91a801211d25904e1f.jpg%401280w_1l_2o_100sh.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bzv55s_z%26e3Bv54_z%26e3BvgAzdH3Fo56hAzdH3FZM3MnMTIyM3A%3D_z%26e3Bip4s%3FfotpviPw2j%3D5g&gsm=0&islist=&querylist=";
    
//    NSString *str = @"http://www.jianshu.com/p/6930f335adba";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    for (int i=0; i<10; i++) {
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"%d---%d",i,i);
            dispatch_semaphore_signal(sem);
        }];
        [task resume];
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        // 这行代码，它是会阻塞线程的，我们如果需要在网络请求完成后修改UI，那这种方式会影响我们的界面交互
    }
    /*
     逻辑：
     遍历—>发起任务—>等待—>任务完成信号量加1—>等待结束,开始下一个任务
     发起任务—>等待—>任务完成信号量加1—>等待结束,开始下一个任务
     发起任务—>等待—>任务完成信号量加1—>等待结束,开始下一个任务
     */
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
}

- (void)demo15 {
    /**
     假设有A、B、C三个操作，要求：
     1. 3个操作都异步执行
     2. 操作C依赖于操作B
     3. 操作B依赖于操作A
     */
    //创建一个队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //可开辟线程的最大数量
    queue.maxConcurrentOperationCount = 3;

    //创建三个任务
    NSBlockOperation *operationA = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"A任务当前线程为：%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operationB = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"B任务当前线程为：%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *operationC = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"C任务当前线程为：%@", [NSThread currentThread]);
    }];
    
    NSLog(@"===== end");
    
    //设置三个任务相互依赖
    // operationB 任务依赖于 operationA
    [operationA addDependency:operationB];
    // operationC 任务依赖于 operationB
    [operationB addDependency:operationC];
    
    
    //添加操作到队列中（自动异步执行任务，并发）
    [queue addOperation:operationA];
    [queue addOperation:operationB];
    [queue addOperation:operationC];
}

- (void)demo16 {
    //创建分组
    dispatch_group_t group =dispatch_group_create();
    //创建队列
    dispatch_queue_t queue =dispatch_queue_create("queue",DISPATCH_QUEUE_CONCURRENT);
        //往分组中添加任务
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        void (^task)(void) = ^{
            [NSThread sleepForTimeInterval:2];//模拟耗时操作
            NSLog(@"11111 %@", [NSThread currentThread]);
            dispatch_group_leave(group);
        };
        dispatch_async(dispatch_get_global_queue(0,0), task);
        NSLog(@"11111---- %@", [NSThread currentThread]);
    });
    
    //往分组中添加任务
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        void (^task)(void) = ^ {
            [NSThread sleepForTimeInterval:1];//模拟耗时操作
            NSLog(@"2222 %@", [NSThread currentThread]);
            dispatch_group_leave(group);
        };
        dispatch_async(dispatch_get_global_queue(0,0), task);
        NSLog(@"2222------- %@", [NSThread currentThread]);
    });
    
    //分组中任务完成以后通知该block执行
    dispatch_group_notify(group, queue, ^{
        NSLog(@"完成 %@", [NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"通知主线程刷新UI %@", [NSThread currentThread]);
        });
    });
    
    NSLog(@"================ 程序执行到这里");
    
    /*
     执行结果如下：
     2017-10-24 11:48:05.641 iOSTest[35128:902591] 11111---- {number = 3, name = (null)}
     2017-10-2411:48:05.641 iOSTest[35128:902608] 2222------- {number = 4, name = (null)}
     2017-10-24 11:48:06.644iOSTest[35128:902609] 2222 0x60000006cb00>{number = 5, name = (null)}
     2017-10-24 11:48:07.644iOSTest[35128:902593] 11111 0x6080000721c0>{number = 6, name = (null)}
     2017-10-24 11:48:07.644iOSTest[35128:902593] 完成 0x6080000721c0>{number = 6, name = (null)}
     2017-10-24 11:48:07.645iOSTest[35128:902524] 通知主线程刷新UI 0x61000006e280>{number = 1, name = main}
     这样我们想要的得到的结果就实现了。

     */
}
/*
 参考链接：
 https://www.jianshu.com/p/a285361a2085
 https://www.cnblogs.com/yjg2014/p/yjg.html
 */
@end
