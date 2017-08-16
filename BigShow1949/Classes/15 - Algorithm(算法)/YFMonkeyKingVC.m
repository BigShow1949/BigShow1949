//
//  YFMonkeyKingVC.m
//  BigShow1949
//
//  15个人围成一圈，报到三的人退出，然后又从1开始报数
//

#import "YFMonkeyKingVC.h"

@implementation YFMonkeyKingVC


- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    bool a[101]={0};
    int f=0,t=0,s=0;
    int n = 15;
    int m = 3;
    do
    {
        ++t;//逐个枚举圈中的所有位置
        if(t>n)
            t=1;//数组模拟环状，最后一个与第一个相连
        // 第t个位置上人没死，那么就报数
        if(!a[t])
            s++;
        if(s==m)//当前报的数是3
        {
            s=0;//计数器清零
            printf("%d ",t);//输出被杀人编号
            a[t]=1;//此处人已死，设置为空
            f++;//死亡人数+1
        }
    }while(f!=n);//直到所有人都被杀死为止
    printf("\n%d",t);
    
}
@end
