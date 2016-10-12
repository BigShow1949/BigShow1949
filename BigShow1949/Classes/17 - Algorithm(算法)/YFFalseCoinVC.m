//
//  YFFalseCoinVC.m
//  BigShow1949
//
//  题目：
//  有一枚是假币，并且已知假币与真币的重量不同，只有一个天平，用最少的次数找出假币
//
//

#import "YFFalseCoinVC.h"

int SearchFalseCurrency(int a, int s, int e);
int findCoin(int coin[],int front,int back) ;
int max(int ,int);

@implementation YFFalseCoinVC
- (void)viewDidLoad {

    self.view.backgroundColor = [UIColor whiteColor];

    // 8个金币的重量
    //    int a[8] ={1, 1, 1, 2, 1, 1, 1, 1};
    
    //    int result = FindCounterfeitMoney(a,0,7);
    
    int coin[30]={1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};
    printf("那个假币是第%d个金币！\n",findCoin(coin,0,29));
    //     system("PAUSE");
    //    int ax= max(1,2);

}

int max(int a,int b)
{
    if (a>b) return  a;
    else if (a < b)  return b;
    else if (a == b) return b;
    else return a;
    
}


//coin[]是质量，front是第一个，back是最后一个（按照0——29编号）
int findCoin(int coin[],int front,int back)
{
    int i,sumf=0,sumb=0,sum=0;
    if(front+1==back)    // 首先就把出口写好，什么时候推出
    {
        if(coin[front]<coin[back])
            return front+1;
        else
            return back+1;
    }else
        if((back-front+1)%2==0)  //分为两组，每组(back-front)/2个（剩余偶数个）
        {
            for(i=front;i<=front+(back-front)/2;i++)
                sumf=sumf+coin[i];     //sumf是前一组(back-front)/2总质量
            for(i=front+(back-front)/2+1;i<=back;i++)
                sumb=sumb+coin[i];    //sumb是后一组(back-front)/2总质量
            
            if(sumf<sumb)
                return findCoin(coin,front,front+(back-front)/2);
            if(sumf>sumb)
                return findCoin(coin,front+(back-front)/2+1,back);
        }
        else {
                //分为两组，每组(back-front)/2个余1个（剩余奇数个）
                for(i=front;i<=front+(back-front)/2-1;i++)
                    sumf=sumf+coin[i];//sumf是前一组(back-front)/2个总质量
                for(i=front+(back-front)/2+1;i<=back;i++)
                    sumb=sumb+coin[i];       //sumb是后一组(back-front)/2个总质量
                
                sum=coin[front+(back-front)/2];   // sum是剩余的一个金币质量
                
                if(sumf<sumb)
                    return findCoin(coin,front,front+(back-front)/2-1);
                if(sumf>sumb)        // 两组质量比较，返回质量小的一组
                    return findCoin(coin,front+(back-front)/2+1,back);
                else
                    if(sumf+sum==sumb+sum)
                        //直到两组质量相同，剩余的一个为假币，返回编号
                        return front+(back-front)/2+1;
       }
    
    return 0;
}

@end
