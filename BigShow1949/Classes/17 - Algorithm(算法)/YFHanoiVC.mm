//
//  YFHanoiVC.m
//  BigShow1949
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFHanoiVC.h"


@implementation YFHanoiVC

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    int n;
    printf("请输入要移动的块数：");
//    scanf("%d",&n);
    move(3,'a','b','c'); // 函数表示的是：a通过b移动到c上

}

/*
 第一，把a上的n-1个盘通过c移动到b。
 第二，把a上的最下面的盘移到c。
 第三，因为n-1个盘全在b上了，所以把b当做a重复以上步骤就好了。
 */
void move(int n,char a,char b,char c)
{
    //当n只有1个的时候直接从a移动到c，不需要通过b了
    if(n==1)
        printf("\t%c->%c\n",a,c);
    else
    {
        //第n-1个要从a通过c移动到b
        move(n-1,a,c,b);
        
        // 直接从a移动到c
        printf("\t%c->%c\n",a,c);
        
        //n-1个移动过来之后b变开始盘，b通过a移动到c
        move(n-1,b,a,c);
    }
}

@end
