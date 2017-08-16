//
//  YFSortVC.m
//  BigShow1949
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFSortVC.h"

void BubbleSort(int a[], int n);   // 冒泡排序
void InsertSort(int a[], int n);   // 直接插入排序
void ShellSort(int a[], int n);    // 希尔排序
void QuikSort(int a[], int n);    // 快速排序
void SelectSort(int a[], int n);  // 直接选择排序
void HeapSort(int a[],int n);     // 堆排序算法

void MergeSort(int a[],int b[],int ,int );  // 归并排序
void HeapAdjust(int array[],int i, int nLength);


@implementation YFSortVC

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    int a[8] = {46,55,13,42,94,5,17,70};
    //    int a[10] = {9,4,8,1,6,2,7,3,5,0};
    BubbleSort(a, 8);
    //    InsertSort(a, 10);
    //    ShellSort(a, 10);
    //     QuikSort(a, 8);
    //    SelectSort(a, 8);
    //    HeapSort(a,8);
    
    //    int b[8];
    //    MergeSort(a,b,0,7);
    
    
    // 输出数组 a里的每个元素
    for (int i = 0; i < 8; i++) {
        printf("%d ",a[i]);
    }
}



#pragma mark - 冒泡排序
void BubbleSort(int a[], int n)
{
    for (int i = 0; i < n; i++)
        for (int j = i+1; j < n; j++)
            if (a[j] > a[i]) {
                int temp =a[i];
                a[i] = a[j];
                a[j] = temp;
            }
}


#pragma mark - 快速排序
void QuikSort(int a[], int numsize)
{
    int i=0,j=numsize-1;
    int val=a[0];/*指定参考值val大小*/
    if(numsize>1)/*确保数组长度至少为2，递归出口，这里很重要*/
    {
        while(i<j)/*循环结束条件*/
        {
            /*从后向前搜索比val小的元素，找到后填到a[i]中并跳出循环*/
            for(;j>i;j--)
                if(a[j]<val)
                {
                    a[i++]=a[j];
                    break;
                }
            /*从前往后搜索比val大的元素，找到后填到a[j]中并跳出循环*/
            for(;i<j;i++)
                if(a[i]>val)
                {
                    a[j--]=a[i];
                    break;
                }
        }
        a[i]=val;/*将保存在val中的数放到a[i]中*/
        
        QuikSort(a,i);/*递归，对前i个数排序*/
        QuikSort(a+i+1,numsize-1-i);/*对i+1到numsize-1这numsize-1-i个数排序*/
        
    }
    
}


#pragma mark - 直接插入排序
// 将还没参加排序的数字，跟已经排序好了得数组来逐个比较，刚好比某个数据大得时候，就插入
void InsertSort(int a[], int n)
{
    int i,j;
    //循环从第2个元素开始
    for(i = 1; i < n; i++)
    {
        if(a[i-1] < a[i])
        {
            // temp是待排序数组的第一个元素
            int temp = a[i];
            for(j=i-1; j>=0 && a[j]<temp; j--)
                a[j+1] =a [j];
            
            // for循环里还要执行一次j--
            a[j+1] = temp;
        }
    }
    
    //    int i,j;
    //    // x是待排序数组的第一个元素
    //    int x;
    //    for ( i = 1; i < n; i++)
    //    {
    //        x = a[i];
    //        for (j = i - 1; j >= 0; j--)
    //            if (a[j] > x)
    //                a[j+1] = a[i];
    //
    //        // 如果已经排好序的数组，最大元素都比x小，就不需要排序
    //            else
    //                break;
    //
    //        a[j+1] = x;
    //
    //    }
    
    
}


#pragma mark - 希尔排序
//  d=5，对数据按照1、2、3、4、5来编号，分别比较编号相同的数据
//  然后d=2，对数据按照1、2来编号
//  最后d=1，算完后就排好了
void ShellSort(int a[], int n)
{
    int i,j,d;
    int x;
    // 这个d的值是随便取的，不超过10就行了
    d=n/2;
    while(d>=1)
    {
        for(i=d;i < n;i++)
        {
            x=a[i];
            for(j=i-d;j>=0;j-=d)
                if(a[j]>x)
                    a[j+d]=a[j];
                else
                    break;
            a[j+d]=x;
        }
        // 这里可以输出数组看看每次分组完后的结果
        // 这里的数字控制d分成几组，如果是1得话，d为：5、2、1
        d>>=1;
    }
}


#pragma mark - 直接选择排序
// 跟冒泡排序的区别：
/*
 跟冒泡排序的联系：
 区别：
 最大值的交换方式不同，直接选择排序是记录最大值的下标，然后跟需要遍历的数组第一个数字
 交换，而冒泡排序是用需要遍历的数组的第一个数字跟后面的数字逐个比较，发现更大的数字就
 交换。
 
 相同点：
 都是两个for循环，两两逐一比较。
 */
void SelectSort(int a[], int n)
{
    for (int i = 0; i < n; i++)
    {
        int k = i;  // k用来标记最大值的下标
        for (int j = i+1; j < n; j++)
            if (a[j] > a[k])
                k = j;
        
        // 最大值跟a[i]换位置，a[i]是遍历数组的第一个数
        int temp =a[k];
        a[k] = a[i];
        a[i] = temp;
    }
    
}


#pragma mark - 堆排序
void HeapSort(int array[],int length)
{
    int tmp;
    /*
     调整序列的前半部分元素，调整完之后第一个元素是序列的最大的元素,
     调整节点：3、2、1、0，这些都是有子节点的，调整后，以这些节点为根节点的二叉树，根节点都是最大的。
     或者理解为：任何一个小二叉树都可以看做是一个大根堆。
     */
    //length/2-1是最后一个非叶节点
    for(int i=length/2-1;i>=0;--i)
        HeapAdjust(array,i,length);
    
    //从最后一个元素开始对序列进行调整，不断的缩小调整的范围直到第一个元素
    for(int i = length-1;i>0;--i)
    {
        //把第一个元素(当前最大元素)和当前的最后一个元素交换，
        //保证当前的最后一个位置的元素都是在现在的这个序列之中最大的
        ///Swap(&array[0],&array[i]);
        tmp = array[i];
        array[i]=array[0];
        array[0]=tmp;
        // 不断缩小调整heap的范围，每一次调整完毕保证第一个元素是当前序列的最大值
        // 为什么这里调用一次就可以保证 a[0]最大呢？
        // 因为之前的 for(int i=length/2-1;i>=0;--i) 循环就保证了以每个节点为根节点的二叉树都是
        // 大根堆，也即是说，a[1]或者 a[2]里面有一个值是当前需调整对象的最大值，所以调用一次就行了
        HeapAdjust(array,0,i);
    }
}

//array是待调整的堆数组，i是待调整的数组元素的位置，nlength是数组的长度
//本函数功能是：以i这个节点为根节点，构建大根堆，（即跟以i为父节点，跟i的最大子节点交换数值 ）
void HeapAdjust(int array[],int i, int nLength)
{
    int nChild;
    int nTemp;
    for(;2*i+1<nLength;i=nChild)
    {
        //子结点的位置=2*（父结点位置）+1
        nChild=2*i+1;
        //得到子结点中较大的结点
        if(nChild<nLength-1 && array[nChild+1]>array[nChild])
            ++nChild;
        //如果较大的子结点大于父结点那么把较大的子结点往上移动，替换它的父结点
        if(array[i]<array[nChild])
        {
            nTemp = array[i];
            array[i] = array[nChild];
            array[nChild] = nTemp;
        }
        else
            //否则退出循环
            break;
    }
}


#pragma mark - 归并排序
/*
 先拆，拆的同时两两排序，合并，两两合并
 
 */
void Merge(int a[],int b[],int s,int m,int e)
{
    int i,j,k;
    // m、e是不动的，j来记录数组b存到哪里了，s判断前半段，i判断后半段
    for(i=m+1,j=s; s<=m && i<=e; j++)
    {
        // printf("s:%d m:%d e:%d i:%d j:%d\n",s,m,e,i,j);
        // 谁小就把谁放到数组b中，同时往后移动一位，
        if(a[s] <= a[i])
            b[j]=a[s++];
        else
            b[j]=a[i++];
    }
    
    // s这个时候没有超过m，而i超过了e，所以上面的循环结束了
    if(s <= m)
    {
        for(k = 0;k <= m-s; k++)
            b[j+k] = a[s+k];
    }
    
    // i这个时候没有超过e，而s超过了m，所以上面的循环结束了
    if(i <= e)
    {
        for( k=0 ; k<= e-i; k++)
            b[j+k] = a[i+k];
    }
}
//内部使用递归，空间复杂度为n+logn
void MergeSort(int a[],int b[],int s,int e)
{
    
    int m, *temp;
    // 一定要记住，递归要一个出口
    if(s == e)
    {
        b[s] = a[s];
    }
    else
    {
        temp = (int*)malloc((e - s+1)*sizeof(int));
        m = (s + e)/2;
        MergeSort(a, temp, s, m);
        MergeSort(a, temp, m+1, e);
        // 查看递归过程，只看最后一个0、3、7的就可以了
        // printf("s:%d m:%d e:%d \n",s,m,e);
        Merge(temp, b, s, m, e);
    }
}


@end
