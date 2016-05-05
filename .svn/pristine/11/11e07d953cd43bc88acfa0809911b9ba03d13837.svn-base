//
//  UITableView+Gzw.m
//  跑腿
//
//  Created by sky33 on 16/1/12.
//  Copyright © 2016年 paotui. All rights reserved.
//

#import "UITableView+Gzw.h"
#import <objc/runtime.h>

@implementation UITableView (Gzw)
static const BOOL loadingKey;
static const char loadedImageNameKey;
static const char descriptionTextKey;
static const char buttonTextKey;
static const char buttonNormalColorKey;
static const char buttonHighlightColorKey;
static const CGFloat dataVerticalOffsetKey;


id (^block)();
////load方法会在类第一次加载的时候被调用
////调用的时间比较靠前，适合在这个方法里做方法交换
//+ (void)load{
//    //方法交换应该被保证，在程序中只会执行一次
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        //获得viewController的生命周期方法的selector
//        SEL systemSel = @selector(initWithFrame:style:);
//        //自己实现的将要被交换的方法的selector
//        SEL swizzSel = @selector(swiz_init);
//        //两个方法的Method
//        Method systemMethod = class_getInstanceMethod([self class], systemSel);
//        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
//        
//        //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
//        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
//        if (isAdd) {
//            //如果成功，说明类中不存在这个方法的实现
//            //将被交换方法的实现替换到这个并不存在的实现
//            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
//        }else{
//            //否则，交换两个方法的实现
//            method_exchangeImplementations(systemMethod, swizzMethod);
//        }
//    });
//}
//
//- (void)swiz_init{
//    //这时候调用自己，看起来像是死循环
//    //但是其实自己的实现已经被替换了
//     NSLog(@"swizzle");
//    
//    [self swiz_init];
//   
//}

#pragma mark set Mettod
-(void)setLoading:(BOOL)loading
{
    if (self.loading == loading) {
        return;
    }
    // 这个&loadingKey也可以理解成一个普通的字符串key，用这个key去内存寻址取值
    objc_setAssociatedObject(self, &loadingKey, @(loading), OBJC_ASSOCIATION_ASSIGN);
    // 一定要放在后面，因为上面的代码在设值，要设置完之后数据源的判断条件才能成立
//    if (loading == YES) {// 第一次的时候设置代理
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        [self reloadEmptyDataSet];
//    }


    
    
    
//    if (loading == NO) {
//        [self reloadEmptyDataSet];
//    }else {
//        __weak __typeof(&*self)weakSelf = self;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (loading) {
//                if (weakSelf.emptyDataSetVisible) {
////                [weakSelf reloadData];
//                    weakSelf.loading = NO;
//                }
//            }
//        });
//    }
}
-(void)setLoadingClick:(void (^)())loadingClick
{
    objc_setAssociatedObject(self, &block, loadingClick, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void)setLoadedImageName:(NSString *)loadedImageName
{
    objc_setAssociatedObject(self, &loadedImageNameKey, loadedImageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void)setDataVerticalOffset:(CGFloat)dataVerticalOffset
{
    objc_setAssociatedObject(self, &dataVerticalOffsetKey,@(dataVerticalOffset),OBJC_ASSOCIATION_RETAIN);// 如果是对象，请用RETAIN。坑
}
-(void)setDescriptionText:(NSString *)descriptionText
{
    objc_setAssociatedObject(self, &descriptionTextKey, descriptionText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void)setButtonText:(NSString *)buttonText
{
    objc_setAssociatedObject(self, &buttonTextKey, buttonText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void)setButtonNormalColor:(UIColor *)buttonNormalColor
{
    objc_setAssociatedObject(self, &buttonNormalColorKey, buttonNormalColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)setButtonHighlightColor:(UIColor *)buttonHighlightColor
{
    objc_setAssociatedObject(self, &buttonHighlightColorKey, buttonHighlightColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)gzwLoading:(loadingBlock)block
{
    if (self.loadingClick) {
        block = self.loadingClick;
    }
    self.loadingClick = block;
}

#pragma mark get Mettod
-(BOOL)loading
{
    // 注意，取出的是一个对象，不能直接返回
    id tmp = objc_getAssociatedObject(self, &loadingKey);
    NSNumber *number = tmp;
    return number.unsignedIntegerValue;
}
-(void (^)())loadingClick
{
    return objc_getAssociatedObject(self, &block);
}
-(NSString *)loadedImageName
{
    return objc_getAssociatedObject(self, &loadedImageNameKey);
}
-(CGFloat)dataVerticalOffset
{
    id temp = objc_getAssociatedObject(self, &dataVerticalOffsetKey);
    NSNumber *number = temp;
    return number.floatValue;
}
-(NSString *)descriptionText
{
    return objc_getAssociatedObject(self, &descriptionTextKey);
}
-(NSString *)buttonText
{
    return objc_getAssociatedObject(self, &buttonTextKey);
}
-(UIColor *)buttonNormalColor
{
    return objc_getAssociatedObject(self, &buttonNormalColorKey);
}
-(UIColor *)buttonHighlightColor
{
    return objc_getAssociatedObject(self, &buttonHighlightColorKey);
}

#pragma mark - DZNEmptyDataSetSource
// 返回一个自定义的view（优先级最高）
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.loading) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        return activityView;
    }else {
        return nil;
    }
}
// 返回一张空状态的图片在文字上面的
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.loading) {
        return nil;
    }
    else {
        NSString *imageName = @"placeholder_fancy";
        if (self.loadedImageName) {
            imageName = self.loadedImageName;
        }
        return [UIImage imageNamed:imageName];
    }
}
// 返回空状态显示title文字，可以返回富文本
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
//{
//    if (self.loading) {
//        return nil;
//    }else {
//        
//        NSString *text = @"没有数据";
//        
//        NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
//        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//        paragraph.alignment = NSTextAlignmentCenter;
//        
//        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
//                                     NSForegroundColorAttributeName: [UIColor lightGrayColor],
//                                     NSParagraphStyleAttributeName: paragraph};
//        
//        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//    }
//}
// 空状态下的文字详情
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.loading) {
        return nil;
    }else {
        
        NSString *text = @"没有数据！您可以尝试重新获取";
        if (self.descriptionText) {
            text = self.descriptionText;
        }
        NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        paragraph.alignment = NSTextAlignmentCenter;
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                     NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                     NSParagraphStyleAttributeName: paragraph};
        
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
}
// 返回最下面按钮上的文字
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    if (self.loading) {
        return nil;
    }else {
        UIColor *textColor = nil;
        // 某种状态下的颜色
        UIColor *colorOne = [UIColor colorWithRed:253/255.0f green:120/255.0f blue:76/255.0f alpha:1];
        UIColor *colorTow = [UIColor colorWithRed:247/255.0f green:188/255.0f blue:169/255.0f alpha:1];
        // 判断外部是否有设置
        colorOne = self.buttonNormalColor ? self.buttonNormalColor : colorOne;
        colorTow = self.buttonHighlightColor ? self.buttonHighlightColor : colorTow;
        textColor = state == UIControlStateNormal ? colorOne : colorTow;
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                     NSForegroundColorAttributeName: textColor};

        return [[NSAttributedString alloc] initWithString:self.buttonText ? self.buttonText : @"再次刷新" attributes:attributes];
    }
}
// 返回试图的垂直位置（调整整个试图的垂直位置）
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.dataVerticalOffset != 0) {
        return self.dataVerticalOffset;
    }
    return 0.0;
}
#pragma mark - DZNEmptyDataSetDelegate Methods
// 返回是否显示空状态的所有组件，默认:YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}
// 返回是否允许交互，默认:YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    // 只有非加载状态能交互
    return !self.loading;
}
// 返回是否允许滚动，默认:YES
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
// 返回是否允许空状态下的图片进行动画，默认:NO
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return YES;
}
//  点击空状态下的view会调用
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    // 暂时不响应
//    if (self.loadingClick) {
//        self.loadingClick();
//        [self reloadEmptyDataSet];
//    }
}
// 点击空状态下的按钮会调用
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    if (self.loadingClick) {
        self.loadingClick();
        [self reloadEmptyDataSet];
    }
}
@end
