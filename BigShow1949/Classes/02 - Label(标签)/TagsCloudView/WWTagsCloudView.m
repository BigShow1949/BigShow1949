//
//  WWScrollTagsCloud.m
//  SearchTest
//
//  Created by mac on 14-7-24.
//  Copyright (c) 2014年 WangWei. All rights reserved.
//

@interface WWScrollView : UIScrollView
@property (nonatomic) CGFloat parallaxRate;
@end
@implementation WWScrollView
//为了正确处理事件链响应秩序，只能将floatView设为scrollview的子View，然后重写layoutSubviews达到效果，虽然不太合逻辑，但是只能这样了。floatView如果与scrollview同级的话，事件处理上无论用什么办法都达不到如同点击scrollview上的label的同样效果，除非模仿SDK重写scrollview具体的跟踪事件处理机制，但这是不可能的。
-(void)layoutSubviews
{
    UIView* floatView = [self viewWithTag:100];
    floatView.frame = CGRectMake(0, 0, self.contentSize.width * _parallaxRate, self.frame.size.height);
    CGRect tempRect = floatView.frame;
    tempRect.origin.x = -self.contentOffset.x * (_parallaxRate - 1);
    floatView.frame = tempRect;
}

//由于scrollview的子view，也就是floatView的userInteractionEnabled为NO，因此事件链在floatView上会断掉，所以重写hitTest方法，使之能够跳过floatView进行判断
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView* hitView = [super hitTest:point withEvent:event];
    if ([hitView isMemberOfClass:[WWScrollView class]]) {
        for (UIView* subView in [self viewWithTag:100].subviews) {
            CGPoint subPoint = [self convertPoint:point toView:subView];
            if ([subView hitTest:subPoint withEvent:event]) {
                return subView;
            }
        }
    }
    return hitView;
}
@end

#import "WWTagsCloudView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define PADDING_X 20//词间距
#define MARGIN_LEFT 20//左间距
#define MARGIN_TOP 50//上间距
#define LINE_HEIGHT 50//行距


@interface WWTagsCloudView ()
@property (strong, nonatomic) UIScrollView* scrollView;
@property (strong, nonatomic) UIView* floatView;

@property (strong, nonatomic) NSArray* tagArray;
@property (strong, nonatomic) NSArray* tagColorArray;
@property (strong, nonatomic) NSArray* fontArray;
@property (nonatomic) NSInteger lineNum;
@property (nonatomic) CGFloat parallaxRate;
@end
@implementation WWTagsCloudView
-(id)initWithFrame:(CGRect)frame andTags:(NSArray*)tags andTagColors:(NSArray*)tagColors andFonts:(NSArray*)fonts andParallaxRate:(CGFloat)parallaxRate andNumOfLine:(NSInteger)lineNum
{
    //初始化
    self = [super initWithFrame:frame];
    _tagArray = tags;
    _tagColorArray = tagColors;
    _fontArray = fonts;
    _lineNum = lineNum;
    _parallaxRate = parallaxRate < 1 ? 1 : parallaxRate;

    _scrollView = [[WWScrollView alloc] initWithFrame:frame];
    ((WWScrollView*)_scrollView).parallaxRate = _parallaxRate;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    //添加X轴滚动监听
    [self addSubview:_scrollView];
    
    //浮动层
    _floatView = [[UIView alloc] init];
    //为了点击事件能够穿透到scrollView上
    _floatView.userInteractionEnabled = NO;
    _floatView.tag = 100;
    [_scrollView addSubview:_floatView];
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * [self createLbInContainer], 0);

    
    return self;
}


-(void)reloadAllTags
{
    for (UIView* subView in _scrollView.subviews) {
        if ([subView isMemberOfClass:[UILabel class]]) {
            [subView removeFromSuperview];
        }
    }
    for (UIView* subView in _floatView.subviews) {
        if ([subView isMemberOfClass:[UILabel class]]) {
            [subView removeFromSuperview];
        }
    }
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * [self createLbInContainer], 0);
}

-(void)tagClickAtIndex:(UITapGestureRecognizer*)gesture
{
    [self.delegate tagClickAtIndex:gesture.view.tag];
}

-(NSInteger)createLbInContainer
{
    //当前页数
    NSInteger currentPageIndex = 0;
    //创建一个序数数组
    NSMutableArray* indexArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _tagArray.count; i++) {
        [indexArray addObject:[NSNumber numberWithInt:i]];
    }
    
    while (indexArray.count > 0) {
        for (int i = 0; i < _lineNum; i++) {
            //当前tag的X坐标
            CGFloat currentX = arc4random() % (MARGIN_LEFT - PADDING_X + 1) + PADDING_X + SCREEN_WIDTH * currentPageIndex;
            //当前label是属于上层还是下层
            BOOL isFloatLabel = arc4random() % 2;
            while (indexArray.count > 0) {
                NSInteger indexOfIndexArray = arc4random() % indexArray.count;
                //当前取出的标签序号
                NSInteger tagIndex = [indexArray[indexOfIndexArray] intValue];
                
                UILabel* label = [[UILabel alloc] init];
                label.tag = tagIndex;
                //随机文字
                label.text = _tagArray[tagIndex];
                //随机颜色
                label.textColor = _tagColorArray[arc4random() % _tagColorArray.count];
                //随机字体
                label.font = _fontArray[arc4random() % _fontArray.count];
                //设定frame
                label.frame = CGRectMake(currentX, MARGIN_TOP + i * LINE_HEIGHT, [self getLabelWidthWithLabel:label], label.font.lineHeight);
                //如果此标签的右侧超出屏幕，则另起一行
                if (currentX + label.frame.size.width + PADDING_X > SCREEN_WIDTH * (currentPageIndex + 1)) {
                    break;
                }
                currentX += label.frame.size.width + PADDING_X;
                
                //如果是在浮动层上的，那么调整x坐标,y坐标位于同一条线上
                CGRect tempRect = label.frame;
                tempRect.origin.y -= (label.font.lineHeight / 2);
                if (isFloatLabel) {
                    tempRect.origin.x += currentPageIndex * SCREEN_WIDTH * (_parallaxRate - 1);
                    label.frame = tempRect;
                    [_floatView addSubview:label];
                }
                else{
                    label.frame = tempRect;
                    [_scrollView addSubview:label];
                }
                [indexArray removeObject:indexArray[indexOfIndexArray]];
                
                //添加点击事件
                label.userInteractionEnabled = YES;
                UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagClickAtIndex:)];
                [label addGestureRecognizer:tapGesture];
                
                isFloatLabel = !isFloatLabel;
            }
        }
        currentPageIndex++;
    }
    return currentPageIndex;
}

//根据label的字体和文字内容获取label宽度
-(CGFloat)getLabelWidthWithLabel:(UILabel*)label
{
    NSDictionary *attribute = @{NSFontAttributeName: label.font};
    CGSize retSize = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, label.font.lineHeight)
                                              options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute
                                              context:nil].size;
    return retSize.width;
}
@end
