//
//  SYEmotionContentView.m
//  01 - 表情键盘
//
//  Created by apple on 15-1-30.
//  Copyright (c) 2015年 apple. All rights reserved.
//
//

#define SYClickedEmotion @"SYClickedEmotion"
#define SYEmotionButtonDidClickNotification @"SYEmotionButtonDidClickNotification"


#import "SYEmotionContentView.h"
#import "SYEmotion.h"
#import "SYEmotionButton.h"

static const NSUInteger SYMaxRows = 3;
static const NSUInteger SYMaxCols = 7;
static const NSUInteger SYPageSize = SYMaxCols * SYMaxRows - 1;

@interface SYEmotionContentView() <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *divider;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation SYEmotionContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        // 1.UIScollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        // 只要隐藏了滚动条,那么滚动条控件就不会被创建
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        /*
        // 如果截图放大,可以看到小点不是原图片,Pattern这个方法决定了,不管怎么拉伸,他都会把拉伸好的图片再平铺出来,一个图片不够再截取一部分
        pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_keyboard_dot_normal"]];
        pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_keyboard_dot_selected"]];
        // UIPageControl有这两个成员变量,但是是私有的,用KVC
        UIImage*        _currentPageImage;
        UIImage*        _pageImage;
         
         注意:这里可以不加_, 如果是pageImage,相当于点调用setter方法
         pageControl.pageImage = [UIImage imageNamed:@"compose_keyboard_dot_normal"];
         找不到的话,改成员变量,改为_pageImage
         优先级是setter方法,再是_pageImage
         所以效率是_pageImage高
         */
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"_pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"_currentPageImage"];
        
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
        // 3.分割线
        UIView *divider = [[UIView alloc] init];
        divider.backgroundColor = [UIColor grayColor];
        divider.alpha = 0.5;
        [self addSubview:divider];
        self.divider = divider;
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (NSUInteger i = 0; i < count; i++) {
        // 表情按钮
        SYEmotionButton *emotionButton = [[SYEmotionButton alloc] init];
        emotionButton.emotion = emotions[i];
        [emotionButton addTarget:self action:@selector(emotionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:emotionButton];
        
//        // 表情模型
//        SYEmotion *emotion = emotions[i];
//        // 表情按钮
//        UIButton *button = [[UIButton alloc] init];
//        // 只对image有效, 对background没有效果, 如果要取消background的高亮,重写setHighlighted:
//        button.adjustsImageWhenHighlighted = NO;
//        // 图片存放的路径
//        NSString *name = [NSString stringWithFormat:@"%@/%@", emotion.folder, emotion.png];
//        [button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(emotionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.scrollView addSubview:button];
    }
    
    self.pageControl.numberOfPages = (count + SYPageSize - 1) / SYPageSize;
    // 添加删除按钮
    for (NSUInteger i = 0; i < self.pageControl.numberOfPages; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
    }

}

/**
 *  点击表情按钮
 */
- (void)emotionButtonClick:(SYEmotionButton *)emotionButton
{
    NSDictionary *userInfo = @{SYClickedEmotion : emotionButton.emotion};
    [[NSNotificationCenter defaultCenter] postNotificationName:SYEmotionButtonDidClickNotification object:nil userInfo:userInfo];

}

/**
 *  点击删除按钮
 */
- (void)deleteButtonClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SYDeleteButtonDidClickNotification" object:nil];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 0.pageControl
    self.pageControl.width = self.width;
    self.pageControl.height = 25;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 1.scrollView
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    /*
//    NSUInteger count = self.scrollView.subviews.count;
    NSUInteger count = self.emotions.count;
    NSUInteger pageCount = (count + SYPageSize - 1) / SYPageSize;
//    if (count % SYPageSize == 0) {
//        pageCount = count / SYPageSize;
//    }else{
//        pageCount = count / SYPageSize + 1;
//    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * pageCount, 0);
     */
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * self.pageControl.numberOfPages, 0);


    // 2.表情
    CGFloat leftMargin = 15;
    CGFloat topMargin = 15;
    CGFloat buttonW = (self.scrollView.width - 2 * leftMargin) / SYMaxCols;
    CGFloat buttonH = (self.scrollView.height - topMargin) / SYMaxRows;
    
    // 表情按钮数:count = 全部子控件 - 删除按钮
    NSUInteger count = self.scrollView.subviews.count - self.pageControl.numberOfPages;
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *button = self.scrollView.subviews[i];
        button.width = buttonW;
        button.height = buttonH;
        
        if (i >= SYPageSize) {
            UIButton *lastButton = self.scrollView.subviews[i - SYPageSize];
            button.y = lastButton.y;
            button.x = lastButton.x + self.scrollView.width;
        }else{ // 最前面那一页
            NSUInteger row = i / SYMaxCols;
            NSUInteger col = i % SYMaxCols;
            button.x = leftMargin + col * buttonW;
            button.y = topMargin + row * buttonH;
        }
    }
    
    // 3.分割线
    self.divider.height = 1;
    self.divider.width = self.width;
    
    // 4.删除按钮
    for (NSUInteger i = count; i < self.scrollView.subviews.count; i++) {
        UIButton *button = self.scrollView.subviews[i];
        button.width = buttonW;
        button.height = buttonH;
        
        if (i == count) {
            button.x = self.scrollView.width - leftMargin -buttonW;
        }else{
            UIButton *lastButton = self.scrollView.subviews[i - 1];
            button.x = lastButton.x + self.scrollView.width;
        }
        button.y = self.scrollView.height - buttonH;
    }
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNo + 0.5);
}
@end
