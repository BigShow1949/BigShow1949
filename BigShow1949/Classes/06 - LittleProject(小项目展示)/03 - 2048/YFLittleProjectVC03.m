//
//  YFLittleProjectVC03.m
//  BigShow1949
//
//  Created by 杨帆 on 15-9-5.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

#import "YFLittleProjectVC03.h"
#define padding 10
#import "YFLabel.h"
#import "YFRecordData.h"

#define nowScoreBtnPre @"  当前得分  "
#define maxScoreBtnPre @"  最高得分  "
#define revokeBtnPre @"撤销 "






@interface YFLittleProjectVC03 ()<UIAlertViewDelegate>
{
    // 当前手指扫动后, 下次扫动前, 是否所有棋子右边都有数字
    BOOL _isAllChessesNextHaveNum;
    
    int _nowScore;
    int _maxScore;
    
#warning 注意应该可以连着撤销五次
    // 还剩下撤销的次数
    int _revokeCount;
    
}

@property (nonatomic, weak) UIView *boardBgView;  // 棋盘

@property (nonatomic, strong) NSMutableArray *chesses; // 存放当前棋盘中所有棋子(存放类型:UILabel)
@property (nonatomic, strong) NSMutableArray *tempChesses;  // 临时数组 存放棋子位置
@property (nonatomic, strong) NSMutableArray *recordDataes; // 记录每次棋子移动后的所有数据, 元素是YFRecordData类型

@property (nonatomic, strong) UIButton *nowScoreBtn;
@property (nonatomic, strong) UIButton *maxScoreBtn;
@property (nonatomic, strong) UIButton *revoke;

@end

@implementation YFLittleProjectVC03

- (NSMutableArray *)recordDataes{
    if (_recordDataes == nil) {
        _recordDataes = [NSMutableArray array];
    }
    return _recordDataes;
}

- (NSMutableArray *)chesses{
    if (_chesses == nil) {
        _chesses = [NSMutableArray array];
    }
    return _chesses;
}


- (void)viewDidLoad{
    
    _maxScore = 20;
    _revokeCount = 5;
    
    [self makeContentsView];
    
    [self makeChessWithNumber:2 i:0];
    [self makeChessWithNumber:2 i:3];
    
    // 将最开始的两个棋子的数据存入数组
    YFRecordData *recordData = [[YFRecordData alloc] initWithNowScore:_nowScore maxScore:_maxScore array:self.chesses];
    [self.recordDataes addObject:recordData];
    
    
    NSLog(@"改变前---");
    for (YFRecordData *data in self.recordDataes) {
        [self printArray:data.chesses];
        NSLog(@"看看地址data.chesses:%p, self.chesses:%p", data.chesses, self.chesses);
        
    }
    
    //    NSLog(@"随机生成俩数字");
    //    for (YFRecordData *data in self.recordDataes) {
    //        [self printArray:data.chesses];
    //    }
    
    // 测试 BUG
    //    [self.chesses removeAllObjects];    //  移除self.chesses所有数据,self.recordDataes不会变
    YFLabel *label = self.chesses[0];
    [label moveHereWithRow:3 line:3];
    //    _nowScore = 30;  // 修改分数, 也不会变
    //    _maxScore = 4;
    
    NSLog(@"改变chesses后");
    for (YFRecordData *data in self.recordDataes) {
        [self printArray:data.chesses];
    }
    
    // 随机一个2
    //    [self randomChess_2];
    
    [self addSwipeGesture];
    
    // 撤销 默认是黑色 不可点击
    [self.revoke setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.revoke.enabled = NO;
    
    //    // 测试按钮颜色
    //    [self makeChessWithNumber:2 i:0];
    //    [self makeChessWithNumber:4 i:1];
    //    [self makeChessWithNumber:8 i:2];
    //    [self makeChessWithNumber:16 i:3];
    //    [self makeChessWithNumber:32 i:6];
    //    [self makeChessWithNumber:64 i:7];
    //    [self makeChessWithNumber:128 i:5];
    //    [self makeChessWithNumber:256 i:4];
    //    [self makeChessWithNumber:512 i:9];
    //    [self makeChessWithNumber:1024 i:10];
    //    [self makeChessWithNumber:2048 i:12];
    
}

#pragma mark - 监听滑动手势
- (void)addSwipeGesture{
    
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.boardBgView addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.boardBgView addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self.boardBgView addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.boardBgView addGestureRecognizer:recognizer];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    // 撤销按钮颜色变白色 可点击
    self.revoke.enabled = YES;
    [self.revoke setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.tempChesses = [NSMutableArray arrayWithArray:(NSArray *)self.chesses];
    
    [self swipeDirection:recognizer.direction];
    
    // 延迟0.4秒生成一个2
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(randomChess_2) userInfo:nil repeats:NO];
    
}

- (void)swipeDirection:(UISwipeGestureRecognizerDirection)direction{
    
    NSLog(@"马上移动逻辑判断:");
    for (YFRecordData *data in self.recordDataes) {
        [self printArray:data.chesses];
    }
    
    // 这个时候所有数字加了一次(只是挨着的), 所以只需要往右边移动即可(如果不是挨着的,一直右移)
    NSLog(@"_isAllChessesNextHaveNum --- %d", _isAllChessesNextHaveNum);
    _isAllChessesNextHaveNum = NO;
    while (!_isAllChessesNextHaveNum) { // 只要有一个不是,就说明还有空格字
        
        _isAllChessesNextHaveNum = YES;
        for (YFLabel *label in self.chesses) {
            
            switch (direction) {
                case UISwipeGestureRecognizerDirectionRight:
                    [self moveRightWithLabel:label];
                    break;
                case UISwipeGestureRecognizerDirectionLeft:
                    [self moveLeftWithLabel:label];
                    break;
                case UISwipeGestureRecognizerDirectionUp:
                    [self moveUpWithLabel:label];
                    break;
                case UISwipeGestureRecognizerDirectionDown:
                    [self moveDownWithLabel:label];
                    break;
                    
                default:
                    break;
            }
            
        }
    }
    
    // 赋值一下, 让self.chesses中删除了的label, self.chesses这时的个数才是真实的
    self.chesses = [NSMutableArray arrayWithArray:(NSArray *)self.tempChesses];
    
    // 这个时候所有数字已经排ok了, 为下一次手指扫动做准备
    for (YFLabel *label in self.chesses) {
        label.canAdd = YES;
    }
    
}

#pragma mark -
#pragma mark 棋子移动到下一个 做出的逻辑判断
- (void)moveRightWithLabel:(YFLabel *)label{
    
    if (label.line == 4) return;
    
    BOOL isNextNum = [self isHereHaveNumWithRow:label.row line:(label.line + 1)];
    
    
    if (isNextNum) {  // 有数字  那么 self.tempChesses 对应的位置也有数字
        NSLog(@"右边移动且有数字:");
        for (YFRecordData *data in self.recordDataes) {
            [self printArray:data.chesses];
        }
        
        YFLabel *nextLabel = [self getLabelInArrar:self.chesses row:label.row line:label.line + 1];
//        YFLabel *nextTempLabel = [self getLabelInArrar:self.tempChesses row:label.row line:label.line + 1];
        
        NSLog(@"下一个有数字");
        
        NSLog(@"label.number --- %d, row:%d, line:%d", label.number, label.row, label.line);  // 8
        NSLog(@"nextTempLabel.number --- %d, row:%d, line:%d", nextLabel.number, nextLabel.row, nextLabel.line);
        
        NSLog(@"self.chesses:%p, self.tempChesses:%p", self.chesses, self.tempChesses);
        
        // 判断当前的数字(self.chesses)跟右边的数字(self.chesses)是否相等
        if ((label.number == nextLabel.number) && label.canAdd && nextLabel.canAdd) {
            
            // 任何其中一个相加, 另外一个就变了, 所以下面的一个注释掉
            
            nextLabel.number = nextLabel.number * 2;
            nextLabel.canAdd = NO;
            [self upDateScore:label.number];
            
            
            //            nextTempLabel.number = nextTempLabel.number * 2;
            //            nextTempLabel.canAdd = NO;
            
            // 从数组中移除 没有成功 (这里的赋值可以移动到上面)
            NSMutableArray *myTempChesses = [NSMutableArray arrayWithArray:self.tempChesses];
            for (YFLabel *tempLabel in myTempChesses) {
                if (tempLabel.row == label.row && tempLabel.line == label.line) {
                    [self.tempChesses removeObject:tempLabel];
                }
            }
            
            NSLog(@"相加,删除后的self.tempChesses是:");
            [self printArray:self.tempChesses];
            //  这个时候的tempChesses又相加了又删除了, 而self.chesses没有删除只相加了
            
            // 这两个是否多余, 不多余, 来模拟删除,上面isHereHaveNumWithRow会用到
            [label removeFromSuperview];
            label.row = 0;
            label.line = 0;
        }
        
        
    }else{ // 没有数字, 直接移动
        
        NSLog(@"没有数字往右边移动前:");
        for (YFRecordData *data in self.recordDataes) {
            [self printArray:data.chesses];
        }
        
        // 有一个不是, 就说明不是所有的
        _isAllChessesNextHaveNum = NO;
        NSLog(@"下一个没有数字, 当前数字为:%d", label.number);
        [label moveHereWithRow:label.row line:label.line + 1];
        NSLog(@"移动后的位置 行:%d 列:%d", label.row, label.line);
        
        NSLog(@"没有数字,self.chesses:");
        [self printArray:self.chesses];
        
        // self.tempChesses需要移动吗?如果最后没有相加
        // label已经 +1了, 所以需要 -1
        YFLabel *tempLabel = [self getLabelInArrar:self.tempChesses row:label.row line:label.line - 1];
        [tempLabel moveHereWithRow:label.row line:label.line];
        NSLog(@"没有数字,self,tempChesses:");
        [self printArray:self.tempChesses];
        
        NSLog(@"右边移动且没有数字:");
        for (YFRecordData *data in self.recordDataes) {
            [self printArray:data.chesses];
        }
        
    }
    
}

- (void)moveLeftWithLabel:(YFLabel *)label{
    
    // 因为后面会用line设置为0 模拟label被删除了
    if (label.line == 1 || label.line == 0) return;
    
    BOOL isNextNum = [self isHereHaveNumWithRow:label.row line:(label.line - 1)];
    
    if (isNextNum) {  // 有数字  那么 self.tempChesses 对应的位置也有数字
        
        YFLabel *nextLabel = [self getLabelInArrar:self.chesses row:label.row line:label.line - 1];
        YFLabel *nextTempLabel = [self getLabelInArrar:self.tempChesses row:label.row line:label.line - 1];
        
        NSLog(@"下一个有数字");
        
        // 判断当前的数字(self.chesses)跟右边的数字(self.chesses)是否相等
        if ((label.number == nextLabel.number) && label.canAdd && nextLabel.canAdd) {
            
            // 任何其中一个相加, 另外一个就变了, 所以下面的一个注释掉
            
            nextLabel.number = nextLabel.number * 2;
            nextLabel.canAdd = NO;
            [self upDateScore:label.number];
            
            //            nextTempLabel.number = nextTempLabel.number * 2;
            //            nextTempLabel.canAdd = NO;
            
            // 从数组中移除 没有成功 (这里的赋值可以移动到上面)
            NSMutableArray *myTempChesses = [NSMutableArray arrayWithArray:self.tempChesses];
            for (YFLabel *tempLabel in myTempChesses) {
                if (tempLabel.row == label.row && tempLabel.line == label.line) {
                    
                    NSLog(@"即将删除的数字:%zd, row:%zd, line:%d", tempLabel.number, tempLabel.row, tempLabel.line);
                    [self.tempChesses removeObject:tempLabel];
                    
                }
            }
            
            NSLog(@"相加,删除后的self.tempChesses是:");
            [self printArray:self.tempChesses];
            //  这个时候的tempChesses又相加了又删除了, 而self.chesses没有删除只相加了
            
            // 这两个是否多余, 不多余, 来%d拟删除,上面isHereHaveNumWithRow会用到
            [label removeFromSuperview];
            label.row = 0;
            label.line = 0;
        }
        
        
    }else{ // 没有数字, 直接移动
        
        // 有一个不是, 就说明不是所有的
        _isAllChessesNextHaveNum = NO;
        NSLog(@"下一个没有数字, 当前数字为:%d", label.number);
        [label moveHereWithRow:label.row line:label.line - 1];
        NSLog(@"移动后的位置 行:%d 列:%d", label.row, label.line);
        
        NSLog(@"没有数字,self.chesses:");
        [self printArray:self.chesses];
        
        // self.tempChesses需要移动吗?如果最后没有相加
        // label已经 -1了, 所以需要 +1
        YFLabel *tempLabel = [self getLabelInArrar:self.tempChesses row:label.row line:label.line + 1];
        [tempLabel moveHereWithRow:label.row line:label.line];
        NSLog(@"没有数字,self,tempChesses:");
        [self printArray:self.tempChesses];
    }
    
    
    
    
}

- (void)moveDownWithLabel:(YFLabel *)label{
    
    if (label.row == 4) return;
    
    BOOL isNextNum = [self isHereHaveNumWithRow:label.row + 1 line:label.line];
    
    
    if (isNextNum) {  // 有数字  那么 self.tempChesses 对应的位置也有数字
        
        YFLabel *nextLabel = [self getLabelInArrar:self.chesses row:label.row + 1 line:label.line];
        YFLabel *nextTempLabel = [self getLabelInArrar:self.tempChesses row:label.row + 1 line:label.line];
        
        NSLog(@"下一个有数字");
        
        NSLog(@"label.number --- %zd, row:%zd, line:%d", label.number, label.row, label.line);
        NSLog(@"nextTempLabel.number --- %d, row:%d, line:%d", nextLabel.number, nextLabel.row, nextLabel.line);
        
        NSLog(@"self.chesses:%p, self.tempChesses:%p", self.chesses, self.tempChesses);
        
        // 判断当前的数字(self.chesses)跟下边的数字(self.chesses)是否相等
        if ((label.number == nextLabel.number) && label.canAdd && nextLabel.canAdd) {
            
            // 任何其中一个相加, 另外一个就变了, 所以下面的一个注释掉
            
            nextLabel.number = nextLabel.number * 2;
            nextLabel.canAdd = NO;
            [self upDateScore:label.number];
            
            //            nextTempLabel.number = nextTempLabel.number * 2;
            //            nextTempLabel.canAdd = NO;
            
            // 从数组中移除 没有成功 (这里的赋值可以移动到上面)
            NSMutableArray *myTempChesses = [NSMutableArray arrayWithArray:self.tempChesses];
            for (YFLabel *tempLabel in myTempChesses) {
                if (tempLabel.row == label.row && tempLabel.line == label.line) {
                    
                    NSLog(@"即将删除的数字:%zd, row:%zd, line:%zd", tempLabel.number, tempLabel.row, tempLabel.line);
                    [self.tempChesses removeObject:tempLabel];
                    
                }
            }
            
            NSLog(@"相加,删除后的self.tempChesses是:");
            [self printArray:self.tempChesses];
            //  这个时候的tempChesses又相加了又删除了, 而self.chesses没有删除只相加了
            
            // 这两个是否多余, 不多余, 来模拟删除,上面isHereHaveNumWithRow会用到
            [label removeFromSuperview];
            label.row = 0;
            label.line = 0;
        }
        
        
    }else{ // 没有数字, 直接移动
        // 有一个不是, 就说明不是所有的
        _isAllChessesNextHaveNum = NO;
        NSLog(@"下一个没有数字, 当前数字为:%d", label.number);
        [label moveHereWithRow:label.row + 1 line:label.line];
        NSLog(@"移动后的位置 行:%d 列:%d", label.row, label.line);
        
        NSLog(@"没有数字,self.chesses:");
        [self printArray:self.chesses];
        
        // self.tempChesses需要移动吗?如果最后没有相加
        // label已经 +1了, 所以需要 -1
        YFLabel *tempLabel = [self getLabelInArrar:self.tempChesses row:label.row - 1 line:label.line];
        [tempLabel moveHereWithRow:label.row line:label.line];
        NSLog(@"没有数字,self,tempChesses:");
        [self printArray:self.tempChesses];
        
    }
    
    
}

- (void)moveUpWithLabel:(YFLabel *)label{
    
    // 因为后面会用line设置为0 模拟label被删除了
    if (label.row == 1 || label.row == 0) return;
    
    BOOL isNextNum = [self isHereHaveNumWithRow:label.row - 1 line:label.line];
    
    if (isNextNum) {  // 有数字  那么 self.tempChesses 对应的位置也有数字
        
        YFLabel *nextLabel = [self getLabelInArrar:self.chesses row:label.row - 1 line:label.line];
        YFLabel *nextTempLabel = [self getLabelInArrar:self.tempChesses row:label.row - 1 line:label.line];
        
        NSLog(@"下一个有数字");
        
        NSLog(@"label.number --- %zd, row:%zd, line:%d", label.number, label.row, label.line);  // 8
        NSLog(@"nextTempLabel.number --- %d, row:%d, line:%d", nextLabel.number, nextLabel.row, nextLabel.line);
        
        NSLog(@"self.chesses:%p, self.tempChesses:%p", self.chesses, self.tempChesses);
        
        // 判断当前的数字(self.chesses)跟右边的数字(self.chesses)是否相等
        if ((label.number == nextLabel.number) && label.canAdd && nextLabel.canAdd) {
            
            // 任何其中一个相加, 另外一个就变了, 所以下面的一个注释掉
            
            nextLabel.number = nextLabel.number * 2;
            nextLabel.canAdd = NO;
            [self upDateScore:label.number];
            
            //            nextTempLabel.number = nextTempLabel.number * 2;
            //            nextTempLabel.canAdd = NO;
            
            // 从数组中移除 没有成功 (这里的赋值可以移动到上面)
            NSMutableArray *myTempChesses = [NSMutableArray arrayWithArray:self.tempChesses];
            for (YFLabel *tempLabel in myTempChesses) {
                if (tempLabel.row == label.row && tempLabel.line == label.line) {
                    
                    NSLog(@"即将删除的数字:%zd, row:%zd, line:%zd", tempLabel.number, tempLabel.row, tempLabel.line);
                    [self.tempChesses removeObject:tempLabel];
                    
                }
            }
            
            NSLog(@"相加,删除后的self.tempChesses是:");
            [self printArray:self.tempChesses];
            //  这个时候的tempChesses又相加了又删除了, 而self.chesses没有删除只相加了
            
            // 这两个是否多余, 不多余, 来模拟删除,上面isHereHaveNumWithRow会用到
            [label removeFromSuperview];
            label.row = 0;
            label.line = 0;
        }
        
        
    }else{ // 没有数字, 直接移动
        
        // 有一个不是, 就说明不是所有的
        _isAllChessesNextHaveNum = NO;
        NSLog(@"下一个没有数字, 当前数字为:%d", label.number);
        [label moveHereWithRow:label.row - 1 line:label.line];
        NSLog(@"移动后的位置 行:%d 列:%d", label.row, label.line);
        
        NSLog(@"没有数字,self.chesses:");
        [self printArray:self.chesses];
        
        // self.tempChesses需要移动吗?如果最后没有相加
        // label已经 -1了, 所以需要 +1
        YFLabel *tempLabel = [self getLabelInArrar:self.tempChesses row:label.row + 1 line:label.line];
        [tempLabel moveHereWithRow:label.row line:label.line];
        NSLog(@"没有数字,self,tempChesses:");
        [self printArray:self.tempChesses];
    }
    
}



#pragma mark - 自定义方法
/**
 *  判断 row行line列 是否有数字
 */
- (BOOL)isHereHaveNumWithRow:(int)row line:(int)line{
    
    BOOL isHereNum = false;
    for (YFLabel *label in self.chesses) {
        if (label.row == row && label.line == line) {
            isHereNum = true;
        }
    }
    
    return isHereNum;
}

/**
 *  取出数组array中 第row行line列的元素
 *
 *  注意:这里数组元素类型是 YFLabel
 */
- (YFLabel *)getLabelInArrar:(NSMutableArray *)array row:(int)row line:(int)line{
    
    YFLabel *thisLabel;
    for (YFLabel *label in array) {
        if (label.row == row && label.line == line) {
            thisLabel = label;
        }
    }
    return thisLabel;
}



#pragma mark - 生成棋子
/**
 *  随机在没有棋子的地方生成一个 "2"
 */
- (void)randomChess_2{
    
    NSLog(@"####### 随机生成2 ########");
    
    BOOL isHereHaveNum = false;
    int i = 0;
    // 首先找出没有棋子的地方
    do {
        i = arc4random() % 16 ;
        isHereHaveNum = [self isHereHaveNumWithRow:(i/4 + 1) line:(i%4 + 1)];
        //        NSLog(@"isHereHaveNum --- %d", isHereHaveNum);
        
    } while (isHereHaveNum);
    
    YFLabel *label = [[YFLabel alloc] init];
    label.number = 2;
    label.row = i/4 + 1;
    label.line = i%4 + 1;
    label.font = [UIFont boldSystemFontOfSize:30];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = YFColor_chess_2;
    
    
    CGFloat chessBgViewX = YFPadding_chess + i%4 * (YFPadding_chess + YFChessWH);
    CGFloat chessBgViewY = YFPadding_chess + i/4 * (YFPadding_chess + YFChessWH);
    label.frame = CGRectMake(chessBgViewX, chessBgViewY, YFChessWH, YFChessWH);
    [self.boardBgView addSubview:label];
    
    [self.chesses addObject:label];
    
    if (self.chesses.count == 16) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示!" message:@"请重开下一局" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alertView.tag = 1;
        [alertView show];
    }
    
    NSLog(@"随机后数组的个数:%d", self.chesses.count);
    for (YFLabel *label in self.chesses) {
        NSLog(@"number:%d, row:%d, line:%d", label.number, label.row, label.line);
    }
    
    // 将移动后的所有关于棋子信息存入数组
    YFRecordData *recordData = [[YFRecordData alloc] init];
    recordData.chesses = self.chesses;
    recordData.nowScore = _nowScore;
    recordData.maxScore = _maxScore;
    [self.recordDataes addObject:recordData];
    
}

#pragma mark - mainView控件
- (void)makeContentsView{
    
    self.view.backgroundColor = YFColor(237, 237, 237);
    
    CGFloat topBtnH = 44;
    CGFloat topBtnW = 100;
    
    UIButton *resetBtn = [[UIButton alloc] init];
    [resetBtn setTitle:@"重新开始" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    resetBtn.frame = CGRectMake(0, 20, topBtnW, topBtnH);
    [self.view addSubview:resetBtn];
    
    UILabel *gameName = [[UILabel alloc] init];
    gameName.textAlignment = NSTextAlignmentCenter;
    gameName.text = @"我的2048";
    gameName.frame = CGRectMake(0, 0, topBtnW, topBtnH);
    gameName.center = CGPointMake(YFScreen.width * 0.5, 20 + topBtnH *0.5);
    [self.view addSubview:gameName];
    
    UIButton *setting = [[UIButton alloc] init];
    [setting setTitle:@"设置" forState:UIControlStateNormal];
    [setting setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    setting.frame = CGRectMake(YFScreen.width - topBtnW, 20, topBtnW, topBtnH);
    [self.view addSubview:setting];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor blackColor];
    line.alpha = 0.1;
    line.frame = CGRectMake(0, CGRectGetMaxY(setting.frame) , YFScreen.width, 1);
    [self.view addSubview:line];
    
    CGFloat bottomBtnH = 44;
    CGFloat bottomBtnW = 90;
    CGFloat padding_3 = padding * 3;
    
    // 撤销
    UIButton *revoke = [[UIButton alloc] init];
    self.revoke = revoke;
    revoke.backgroundColor = [UIColor blueColor];
    revoke.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    NSString *revokeTemp = [NSString stringWithFormat:@"%@%d", revokeBtnPre, _revokeCount];
    [revoke setTitle:revokeTemp forState:UIControlStateNormal];
    [revoke setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    revoke.frame = CGRectMake(padding, CGRectGetMaxY(line.frame) + padding_3, bottomBtnW, bottomBtnH);
    [revoke addTarget:self action:@selector(revokeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:revoke];
    
    // 当前得分
    UIButton *nowScoreBtn = [[UIButton alloc] init];
    self.nowScoreBtn = nowScoreBtn;
    nowScoreBtn.enabled = NO;
    nowScoreBtn.backgroundColor = [UIColor lightGrayColor];
    NSString *nowScoreBtnTemp = [NSString stringWithFormat:@"%@%@",nowScoreBtnPre, @"0"];
    [nowScoreBtn setTitle:nowScoreBtnTemp forState:UIControlStateNormal];
    nowScoreBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nowScoreBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    nowScoreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [nowScoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nowScoreBtn.frame = CGRectMake(0, 0, bottomBtnW, bottomBtnH);
    nowScoreBtn.center = CGPointMake(YFScreen.width * 0.5, revoke.center.y);
    [self.view addSubview:nowScoreBtn];
    
    // 最高得分
    UIButton *maxScoreBtn = [[UIButton alloc] init];
    self.maxScoreBtn = maxScoreBtn;
    maxScoreBtn.enabled = NO;
    maxScoreBtn.backgroundColor = YFColor(240, 160, 105);
    NSString *maxScoreBtnTemp = [NSString stringWithFormat:@"%@%d", maxScoreBtnPre, _maxScore];
    [maxScoreBtn setTitle:maxScoreBtnTemp forState:UIControlStateNormal];
    maxScoreBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    maxScoreBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    maxScoreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [maxScoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    maxScoreBtn.frame = CGRectMake(YFScreen.width - padding - bottomBtnW, revoke.frame.origin.y, bottomBtnW, bottomBtnH);
    
    [self.view addSubview:maxScoreBtn];
    
    CGFloat maxY = CGRectGetMaxY(nowScoreBtn.frame) + padding_3;
    
    [self makeCheckerboardWithMaxY:maxY];
    
}

/**
 *  画棋盘
 *
 *  @param boardY 棋盘的高度
 */
- (void)makeCheckerboardWithMaxY:(CGFloat)boardY{
    
    UIView *boardBgView = [[UIView alloc] init];
    self.boardBgView = boardBgView;
    boardBgView.backgroundColor = YFColor(173, 158, 145);
    boardBgView.frame = CGRectMake(0, boardY, YFScreen.width, YFScreen.width);
    [self.view addSubview:boardBgView];
    
    
    for (int i = 0; i < 4 * 4; i++) {
        [self makeChessBgViewWithView:boardBgView i:i];
    }
    
}

/**
 *  棋盘每个棋子的背景
 *
 *  @param boardBgView 棋盘
 *  @param i           第多少个棋子 (这里总共4*4个)
 */
- (void)makeChessBgViewWithView:(UIView *)boardBgView i:(int)i{
    
    UIView *chessBgView = [[UIView alloc] init];
    chessBgView.backgroundColor = YFColor(193, 180, 166);
    
    CGFloat chessBgViewX = YFPadding_chess + i%4 * (YFPadding_chess + YFChessWH);
    CGFloat chessBgViewY = YFPadding_chess + i/4 * (YFPadding_chess + YFChessWH);
    chessBgView.frame = CGRectMake(chessBgViewX, chessBgViewY, YFChessWH, YFChessWH);
    [boardBgView addSubview:chessBgView];
    
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 1) {  // 重开下一局
        for (YFLabel *label in self.chesses) {
            [label removeFromSuperview];
        }
        [self.chesses removeAllObjects];
        [self randomChess_2];
        [self randomChess_2];
    }
    
}


/**
 *  测试用的
 *
 *  打印数组里的每个数字、行、列
 */
- (void)printArray:(NSMutableArray *)tempChesses{
    
    for (YFLabel *label in tempChesses) {
        NSLog(@"数字:%d, row:%d, line:%d", label.number, label.row, label.line);
    }
}

/**
 *  测试用的
 *
 *  在第i个格子生成数字number  i:0~15
 */
- (void)makeChessWithNumber:(int)number i:(int)i{
    
    YFLabel *label = [[YFLabel alloc] init];
    label.number = number;
    
    label.row = i/4 + 1;
    label.line = i%4 + 1;
    NSLog(@"row:%d, line:%d", label.row, label.line);
    
    CGFloat chessBgViewX = YFPadding_chess + i%4 * (YFPadding_chess + YFChessWH);
    CGFloat chessBgViewY = YFPadding_chess + i/4 * (YFPadding_chess + YFChessWH);
    label.frame = CGRectMake(chessBgViewX, chessBgViewY, YFChessWH, YFChessWH);
    [self.boardBgView addSubview:label];
    
    [self.chesses addObject:label];
    
}

/**
 *  撤销
 */
- (void)revokeBtnClick{
    NSLog(@"撤销,移动过的次数--self.recordDataes.count:%d", self.recordDataes.count);
    
    for (YFRecordData *data in self.recordDataes) {
        NSLog(@"第%d个数据:", [self.recordDataes indexOfObject:data]);
        [self printArray:data.chesses];
    }
    if (_revokeCount == 0) {
        // 给出提示
        return;
    }
    
    if (self.recordDataes.count == 1) {
        // 提示 已经是第一个了, 不能再撤销了
        return;
    }
    // 删除数组最后一个元素, 然后再获取最后一个元素
    [self.chesses removeAllObjects]; // 这个需要写吗
    [self.recordDataes removeLastObject];
    YFRecordData *recordData = [self.recordDataes lastObject];
    _nowScore = recordData.nowScore;
    _maxScore = recordData.maxScore;
    self.chesses = recordData.chesses;
    
    // 改变撤销次数记录值
    _revokeCount -= 1;
    NSString *revokeTemp = [NSString stringWithFormat:@"%@%d", revokeBtnPre, _revokeCount];
    [self.revoke setTitle:revokeTemp forState:UIControlStateNormal];
    
    // 改变当前得分
    NSString *nowScoreBtnTemp = [NSString stringWithFormat:@"%@%d", nowScoreBtnPre, _nowScore];
    [self.nowScoreBtn setTitle:nowScoreBtnTemp forState:UIControlStateNormal];
    
    // 改变最高得分
    NSString *maxScoreBtnTemp = [NSString stringWithFormat:@"%@%d", maxScoreBtnPre, _maxScore];
    [self.maxScoreBtn setTitle:maxScoreBtnTemp forState:UIControlStateNormal];
    
    // 改变棋子数据
    NSLog(@"当前棋子个数:%d", self.chesses.count);
    [self printArray:self.chesses];
    
    
}

/**
 *  更新当前分数以及最高分数
 */
- (void)upDateScore:(int)addScore{
    
    // 更新分数
    _nowScore += addScore;
    if (_nowScore >= _maxScore) {
        _maxScore = _nowScore;
        NSString *maxScoreTemp = [NSString stringWithFormat:@"%@%d", maxScoreBtnPre, _maxScore];
        [self.maxScoreBtn setTitle:maxScoreTemp forState:UIControlStateNormal];
    }
    NSString *norScoreTemp = [NSString stringWithFormat:@"%@%d", nowScoreBtnPre, _nowScore];
    [self.nowScoreBtn setTitle:norScoreTemp forState:UIControlStateNormal];
    
}

@end
