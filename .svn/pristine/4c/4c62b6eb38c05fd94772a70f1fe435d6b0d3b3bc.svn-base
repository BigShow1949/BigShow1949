//
//  SYComposeViewController.m
//  01 - 表情键盘
//
//  Created by apple on 15-1-30.
//  Copyright (c) 2015年 apple. All rights reserved.
//
#define SYEmotionButtonDidClickNotification @"SYEmotionButtonDidClickNotification"

#import "SYComposeViewController.h"
#import "SYTextView.h"
#import "SYEmotionKeyboard.h"
#import "MJExtension.h"
#import "SYEmotion.h"

@interface SYComposeViewController () <UITextViewDelegate>
@property (nonatomic, weak) SYTextView *textView;
@end

@implementation SYComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setNav];
    
    // 添加输入框
    [self setupTextView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

/**
 *  添加输入框
 */
- (void)setupTextView
{
    // emoji
    SYTextView *textView = [[SYTextView alloc] init];
    textView.placehoder = @"请输入发送消息内容";
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:20];
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 设置弹出的键盘
    SYEmotionKeyboard *keyboard = [[SYEmotionKeyboard alloc] init];
    keyboard.height = 216;
    textView.inputView = keyboard;
    
    // 监听键盘内部删除按钮点击的通知
    [[NSNotificationCenter defaultCenter] addObserverForName:@"SYDeleteButtonDidClickNotification" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [textView deleteBackward];
    }];
    // 监听键盘内部表情按钮点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionButtonClick:) name:SYEmotionButtonDidClickNotification object:nil];
    
}

- (void)emotionButtonClick:(NSNotification *)note
{
    // 生成表情图片路径
    SYEmotion *emotion = note.userInfo[@"SYClickedEmotion"];
    NSString *name = [NSString stringWithFormat:@"%@/%@", emotion.folder, emotion.png];
    
    // 生成一个带图片的属性文字
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:name];
    CGFloat imgWH = self.textView.font.lineHeight;
    attachment.bounds = CGRectMake(0, -4, imgWH, imgWH);
    NSAttributedString *imageString = [NSAttributedString attributedStringWithAttachment:attachment];
    
    // 生成属性文字
    NSUInteger oldLoc = self.textView.selectedRange.location;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    [string appendAttributedString:self.textView.attributedText];
    //        [string insertAttributedString:imageString atIndex:oldLoc];
    [string replaceCharactersInRange:self.textView.selectedRange withAttributedString:imageString];
    
    // textView的font属性\textColor属性只对普通文字(text属性)有效
    // 如果想设置属性文字(attributedText)的字体\文字颜色等状态, 得通过addAttribute等方法添加状态
    [string addAttribute:NSFontAttributeName value:self.textView.font range:NSMakeRange(0, string.length)];
    
    // 一旦重新设置了文字,光标会自动定位到文字最后面
    self.textView.attributedText = string;
    
    // 设置光标
    self.textView.selectedRange = NSMakeRange(oldLoc + 1, 0);

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


/**
 *  设置导航栏内容
 */
- (void)setNav
{
    // 统一设置UIBarButtonItem的主题
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{
                                   NSForegroundColorAttributeName : [UIColor orangeColor]
                                   } forState:UIControlStateNormal];
    
    [item setTitleTextAttributes:@{
                                   NSForegroundColorAttributeName : [UIColor lightGrayColor]
                                   } forState:UIControlStateDisabled];
    
    // 默认是clearColor
    self.view.backgroundColor = [UIColor whiteColor];
    // 导航栏内容
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    
    // 标题
    self.title = @"发送消息";

}

/**
 *  取消
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发送
 */
- (void)send
{
    
}

#pragma mark - <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}



@end
