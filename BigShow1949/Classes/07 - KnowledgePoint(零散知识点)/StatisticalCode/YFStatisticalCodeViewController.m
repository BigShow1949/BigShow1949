//
//  YFStatisticalCodeViewController.m
//  BigShow1949
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFStatisticalCodeViewController.h"

@implementation YFStatisticalCodeViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 89634行
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 100, 300, 100);
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor lightGrayColor];
    label.text = @"请在Mac上运行,不要在iPhone上跑, 目前代码9万行";
    [self.view addSubview:label];
    
    // 注意:代码得在Mac下跑,不能再iPhone上,路径不对
    
    // 在这里写下需要统计的代码的目录
    NSString *path = @"/Users/apple/GitHub/BigShow1949";
//    NSString *path = @"/Users/apple/Desktop/Code/BSJZ/SJZ";

    NSLog(@"在这个文件中代码行数是：%ld",codeLineCount2(path,path));
}


//统计代码行数函数（运用递归）
/*
 url :文件的全路径，可能是文件可能是文件夹
 返回值  NSUInteger  :代码行数
 */
NSUInteger codeLineCount(NSString *url) {
    //1、设置文件管理者对象，判断文件是否存在
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //2、判断文件是文件夹还是文件
    BOOL dir = NO;
    
    //3、设置变量判断文件是否存在
    BOOL isExist = [manager fileExistsAtPath:url isDirectory:&dir];
    
    //如果不存在return 0；
    if (!isExist) {
        NSLog(@"文件路径不存在！");
        return 0;
    }
    
    
    //代码来到这说明路径存在
    //如果是文件夹...
    if (dir) {
        //获取当前文件夹path下面的所有内容（文件夹、文件）名 存在数组中
        NSArray *aryPath = [manager contentsOfDirectoryAtPath:url error:nil];
        
        //定义一个变量保存path中所有文件的总行数
        NSUInteger count = 0;
        
        //遍历数组中所有子文件（夹）名
        for (NSString *fileName in aryPath) {
            //获取子文件（夹）的全路径，运用递归
            NSString *fullPath = [NSString stringWithFormat:@"%@/%@",url,fileName];
            
            //递归累加所有代码行数
            count+=codeLineCount(fullPath);
        }
        return count;
    }
    //如果是文件
    else{
        //判断文件的扩展名,将文件扩展名都转化成lowercaseString小写字母便于之后判断
        NSString *extension = [[url pathExtension]lowercaseString];
        
        if (!([extension isEqualToString:@"m" ] || [extension isEqualToString:@"h"] || [extension isEqualToString:@"h"])) {
            //文件扩展名不是h/m/c
            return 0;
        }
        
        //加载文件内容
        NSString *content = [NSString stringWithContentsOfFile:url encoding:NSUTF8StringEncoding error:nil];
        
        //按换行符分割存入数组中
        NSArray *aryFile = [content componentsSeparatedByString:@"\n"];
        
        
        //返回行数
        return aryFile.count;
    }
    
    
    return 0;
}


// 这就是实现功能的方法，行参是一个路径
NSUInteger codeLineCount2(NSString *path,NSString *rootPath)
{
    NSUInteger num = 0;
    // 判断是否是文件夹，如果说file是文件夹的时候就是YES不是文件夹的话就是NO
    BOOL flag = NO;
    // 首先判断这个文件存不存在，存在的话是文件还是文件夹
    // 关于文件目录的操作，取得文件管理器的单例对象
    NSFileManager *file = [NSFileManager defaultManager];
    BOOL isExit = [file fileExistsAtPath:path isDirectory:&flag];
    if(!isExit){
        NSLog(@"路经有误！！！");
        return 0;
    }else{
        // 如果说他是文件夹的话，就得到他的里面去把文件找出来
        if(flag){
            
            // 获取这个文件夹中的所有的文件名字
            NSArray *a = [file contentsOfDirectoryAtPath:path error:nil];
            for(id fileName in a){
                
                //  获得所有文件的完全路径
                NSString *s1 = [NSString stringWithFormat:@"%@/%@",path,fileName];
                num  = num + codeLineCount2(s1,rootPath);
            }
        }else{
            // 如果说是文件并且扩展名是.h 或者是.m的话就直接进行统计
            NSString *h = @"h";
            NSString *m = @"m";
            NSString *c = @"c";
            NSString *mm = @"mm";
            NSString *swift = @"swift";
            //查看扩展名是否是上面这三个但是，扩展名又可能是大写，所以这个时候就要先把扩展名转为小写再比较
            NSString *pathE = [[path pathExtension] lowercaseString];
            NSRange rect = [path rangeOfString:rootPath];
            NSString *newPath = [path stringByReplacingCharactersInRange:rect withString:@""];
            if([pathE isEqualToString:h] || [pathE isEqualToString:m] || [pathE isEqualToString:c] || [pathE isEqualToString:mm]|| [pathE isEqualToString:swift]){
                num = test2(path);
                NSLog(@"%@  ---  %ld行",newPath,num);
                
            }else{
                
                return 0;
            }
        }
    }
    return num;
}
NSUInteger test2(NSString *path)
{
    // 可以首先获取文件中的内容，然后利用字符串分割计数将空格字符串以回车分割，这个时候会生成一个数组，这个时候我就可以通过计算数组中的元素来计算文档中的行数了
    NSString *s1 = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    // 利用字符串分割函数，将字符串分割生成一个数组
    NSArray *a = [s1 componentsSeparatedByString:@"\n"];
    
    return a.count;
}
@end
