//
//  YFEightQueensVC.m
//  BigShow1949
//
//  题目：
//     在8X8格的国际象棋上摆放八个皇后，使其不能互相攻击，即任意两个皇后都不能处于同一
//  行、同一列或同一斜线上，问有多少种摆法。
//
//

#import "YFEightQueensVC.h"

#define N 8 /* 定义棋盘大小 */
int place(int k); /* 确定某一位置皇后放置与否，放置则返回1，反之返回0 */
void backtrack(int i);/* 主递归函数，搜索解空间中第i层子树 */
void chessboard(); /* 每找到一个解,打印当前棋盘状态 */
static int sum, /* 当前已找到解的个数 */
x[N]; /* 记录皇后的位置,x[i]表示皇后i放在棋盘的第i行的第x[i]列 */


@implementation YFEightQueensVC

- (void)viewDidLoad {

    self.view.backgroundColor = [UIColor whiteColor];
    backtrack(0);
}



int place(int k)
{
    /* 测试皇后k在第k行第x[k]列时是否与前面已放置好的皇后相攻击。 x[j] == */
    /* x[k] 时，两皇后在同一列上；abs(k - j) == abs(x[j] - x[k]) 时，两皇 */
    /* 后在同一斜线上。两种情况两皇后都可相互攻击，故返回0表示不符合条件。*/
    for (int j = 0; j < k; j ++)
        if (abs(k - j) == abs(x[j] - x[k]) || (x[j] == x[k])) return 0;
    return 1;
}
void backtrack(int t)
{
    /* t == N 时，算法搜索至叶结点，得到一个新的N皇后互不攻击的放置方案 */
    if (t == N) chessboard();
    else
        for (int i = 0; i < N; i ++) {
            x[t] = i;
            //            printf("a[%d]=%d",t,i);
            if (place(t)) backtrack(t + 1);
        }
}
void chessboard()
{
    printf("第%d种解法:\n", ++ sum);
    for (int i = 0; i < N; i ++) {
        for (int j = 0; j < N; j ++)
            if (x[i] == j) printf("@ ");
            else printf("* ");
        printf("\n");
    }
    printf("\n");
}

@end
