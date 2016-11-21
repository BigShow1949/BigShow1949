//
//  KVCViewController.m
//  BigShow1949
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "KVCViewController.h"
#import "Person_KVC.h"
#import "Dog_KVC.h"

#import "Author_KVC.h"
#import "Book_KVC.h"

#import "Children_KVO.h"
#import "Nure_KVO.h"

@interface KVCViewController ()
@property (nonatomic, strong) Nure_KVO *nure;

@end

@implementation KVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     参考地址:
     http://blog.csdn.net/jiangwei0910410003/article/details/41912937
     */
    [self testKVC1];
    
    [self testKVC2];
    
    [self testKVO];
}

- (void)testKVC1 {

    Person_KVC *p = [[Person_KVC alloc] init];
    
    //设置值
    //这里setValue方法：第一个参数是value,第二个参数是key(就是类的属性名称)
    [p setValue:@"bigShow" forKey:@"name"];
    //设置基本数据类型
    //这里需要将基本类型转化成NSNumber
    //在设置值的时候，会有自动解包的过程，NSNumber会解包赋值给age
    [p setValue:@22 forKey:@"age"];
    
    
    Dog_KVC *dog = [[Dog_KVC alloc] init];
    [p setValue:dog forKey:@"dog"];
    
    //KVC设置值时，如果属性有set方法，则优先调用set方法，如果没有则直接设置上去，get方法类似
    
    //读取值
    NSString *name = [p valueForKey:@"name"];

    NSLog(@"%@",p);
}

- (void)testKVC2 {
    //------------------KVC键值路径
    /*
     Book *book = [[Book alloc] init];
     Author *author = [[Author alloc] init];
     
     //设置作者
     [book setValue:author forKey:@"author"];
     
     //设置作者的名字
     //路径为：author.name,中间用点号进行连接
     [book setValue:@"bigShow" forKeyPath:@"author.name"];
     NSString *name = [author valueForKey:@"name"];
     NSLog(@"name is %@",name);
     */
    
    
    //--------------------KVC的运算
    Author_KVC *author = [[Author_KVC alloc] init];
    [author setValue:@"莫言" forKeyPath:@"name"];
    
    Book_KVC *book1 = [[Book_KVC alloc] init];
    book1.name = @"红高粱";
    book1.price = 9;
    Book_KVC *book2 = [[Book_KVC alloc] init];
    book2.name = @"蛙";
    book2.price = 10;
    NSArray *array = [NSArray arrayWithObjects:book1,book2, nil];
    [author setValue:array forKeyPath:@"issueBook"];
    
    //基本数据类型会自动被包装成NSNumber，装到数组中
    //得到所有书籍的价格
    NSArray *priceArray = [author valueForKeyPath:@"issueBook.price"];
    NSLog(@"%@",priceArray);
    
    //获取数组的大小
    NSNumber *count = [author valueForKeyPath:@"issueBook.@count"];
    NSLog(@"count=%@",count);
    
    //获取书籍价格的总和
    NSNumber *sum = [author valueForKeyPath:@"issueBook.@sum.price"];
    NSLog(@"%@",sum);
    
    //获取书籍的平均值
    NSNumber *avg = [author valueForKeyPath:@"issueBook.@avg.price"];
    NSLog(@"%@",avg);
    
    //获取书籍的价格最大值和最小值
    NSNumber *max = [author valueForKeyPath:@"issueBook.@max.price"];
    NSNumber *min = [author valueForKeyPath:@"issueBook.@min.price"];

}

- (void)testKVO {

    Children_KVO *baby = [[Children_KVO alloc] init];
    
    Nure_KVO *nure = [[Nure_KVO alloc] initWithChildren:baby];
    self.nure = nure;
}




@end
