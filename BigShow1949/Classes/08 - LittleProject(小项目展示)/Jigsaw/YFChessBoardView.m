//
//  YFChessBoardView.m
//  Jigsaw
//
//  Created by apple on 16/8/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YFChessBoardView.h"
#import "UIColor+Extension.h"
#import "YFCard.h"

typedef enum{
    DIR_NONE = 0,
    DIR_LEFT,
    DIR_UP,
    DIR_RIGHT,
    DIR_DOWN,
}Direction;

YFCard* cardsMap[4][4];
Position nullPosition;

@interface YFChessBoardView ()
@property (nonatomic, strong) NSMutableArray *originArr;


@end

@implementation YFChessBoardView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"frame = %@", NSStringFromCGRect(frame));
        self.backgroundColor = [UIColor colorWithRGBRed:246 green:246 blue:246];
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    // 设置分隔线
    [self setPartitionLine];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {

    _backgroundImage = backgroundImage;
    
    CGFloat picWH = self.frame.size.height/4;
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            
            if (i < 4-1 || j < 4-1) { // 把最后一个(3,3)去掉
                CGRect rect =CGRectMake(picWH*i, picWH*j, picWH, picWH);

                YFCard *card = [[YFCard alloc] initWithImage:[[UIImage alloc] initWithCGImage:CGImageCreateWithImageInRect(backgroundImage.CGImage, rect)]];
                card.position = PositionMake(i, j);
                card.originPosition = PositionMake(i, j);
                [card setDefaultFrame];
                [self addSubview:card];
             
                cardsMap[i][j]=card;
            }
        }
    }
    // 默认是最后一个为空
    nullPosition = PositionMake(4-1, 4-1);
    cardsMap[nullPosition.X][nullPosition.Y] = nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch * touch = [[touches allObjects] objectAtIndex:0];
    CGPoint p = [touch locationInView:self];
    
    CGFloat picWH = self.frame.size.height/4;
    int x = p.x/picWH;
    int y = p.y/picWH;

    YFCard *card = cardsMap[x][y];
    
    switch ([self getDirectionWithCard:card]) {
        case DIR_LEFT:
            [self moveCard:card toPosition:PositionMake(x-1, y)];
            [self checkSuccess];
            break;
        case DIR_UP:
            [self moveCard:card toPosition:PositionMake(x, y-1)];
            [self checkSuccess];
            break;
        case DIR_RIGHT:
            [self moveCard:card toPosition:PositionMake(x+1, y)];
            [self checkSuccess];
            break;
        case DIR_DOWN:
            [self moveCard:card toPosition:PositionMake(x, y+1)];
            [self checkSuccess];
            break;
        default:
            break;
    }
}


- (void)moveCard:(YFCard *)card toPosition:(Position)position {
    
    cardsMap[card.position.X][card.position.Y] = nil;
    nullPosition = card.position;

    cardsMap[position.X][position.Y] = card;
    card.position = position;

    [card moveToTarget:nil action:nil];
}

-(BOOL)checkSuccess{
    
    BOOL success = YES;
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            
            if (cardsMap[i][j]) {
                YFCard *card = cardsMap[i][j];
                if (card.originPosition.X != card.position.X ||
                    card.originPosition.Y != card.position.Y) {
                    success = NO;
                }
            }
        }
    }
    
    if (success) {
        [[[UIAlertView alloc] initWithTitle:@"恭喜您" message:@"拼图成功" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil] show];
    }
    
    return success;
}

-(Direction)getDirectionWithCard:(YFCard *)touchedCard {
    
    int x = touchedCard.position.X;  // 2
    int y = touchedCard.position.Y;  // 3   (y,x)--->(3,2)
    
    // 前面的判断没有用, 肯定是0<index<4的
    if (x>0 && !cardsMap[x-1][y]) { // 左边的值没有
        return DIR_LEFT;
    }
    if (x<4-1 && !cardsMap[x+1][y]) { // 右边的值没有
        return DIR_RIGHT;
    }
    if (y>0 && !cardsMap[x][y-1]) { // 上边的值没有
        return DIR_UP;
    }
    if (y<4-1 && !cardsMap[x][y+1]) {  // 下边的值没有
        return DIR_DOWN;
    }
    return DIR_NONE;
}

#pragma mark - 分隔线
- (void)setPartitionLine {
    
    // 默认四格
    CGFloat padding = self.frame.size.height/4.f;
    
    for (int i = 0; i <= 4; i++) {
        [self addLineWithFrame:CGRectMake(0, padding * i, self.frame.size.height, 1)];
    }
    
    for (int j = 0; j <= 4; j++) {
        [self addLineWithFrame:CGRectMake(padding * j, 0, 1, self.frame.size.height)];

    }
}


- (void)addLineWithFrame:(CGRect)frame {

    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = [UIColor blackColor];
    [UIColor colorWithRGBRed:255 green:255 blue:255];
    [self addSubview:line];
}

#pragma mark - 外部接口
- (void)randomBreak {
    
    for (int i = 0; i < 1000; i++) {
        
        Direction dir = [self getValidRandomDirect];;
        
        int x = nullPosition.X;
        int y = nullPosition.Y;
        switch (dir) {
            case DIR_LEFT:
                x--;
                break;
            case DIR_UP:
                y--;
                break;
            case DIR_RIGHT:
                x++;
                break;
            case DIR_DOWN:
                y++;
                break;
                
            default:
                break;
        }
        
        YFCard *card = cardsMap[x][y];
        [self moveCard:card toPosition:nullPosition];
        
        cardsMap[x][y] = nil;
    }
}

#pragma mark - private
- (Direction)getValidRandomDirect {

    Direction dir = arc4random_uniform(5);
    switch (dir) {
        case DIR_LEFT:
            if (nullPosition.X-1 == -1) {
                return [self getValidRandomDirect];
            }
            break;
        case DIR_UP:
            if (nullPosition.Y-1 == -1) {
                return [self getValidRandomDirect];
            }
            break;
        case DIR_RIGHT:
            if (nullPosition.X+1 == 4) {
                return [self getValidRandomDirect];
            }
            break;
        case DIR_DOWN:
            if (nullPosition.Y+1 == 4) {
                return [self getValidRandomDirect];
            }
            break;
            
        default:
            return [self getValidRandomDirect];
            break;
    }
    return dir;
}

#pragma mark - 懒加载
- (NSMutableArray *)originArr {

    if (!_originArr) {
        _originArr = [NSMutableArray array];
    }
    return _originArr;
}
@end
