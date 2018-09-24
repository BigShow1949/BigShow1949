//
//  UIScrollView+YNPageExtend.m
//  YNPageViewController
//
//  Created by ZYN on 2018/5/8.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "UIScrollView+YNPageExtend.h"
#import <objc/runtime.h>

@implementation UIScrollView (YNPageExtend)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:NSSelectorFromString(@"_notifyDidScroll") withMethod:@selector(yn_scrollViewDidScrollView)];
        [self swizzleInstanceMethod:NSSelectorFromString(@"_scrollViewWillBeginDragging") withMethod:@selector(yn_scrollViewWillBeginDragging)];
    });
}

- (void)yn_scrollViewDidScrollView {
    [self yn_scrollViewDidScrollView];
    if (self.yn_observerDidScrollView && self.yn_pageScrollViewDidScrollView) {
        self.yn_pageScrollViewDidScrollView(self);
    }
}

- (void)yn_scrollViewWillBeginDragging {
    
    [self yn_scrollViewWillBeginDragging];
    if (self.yn_observerDidScrollView && self.yn_pageScrollViewBeginDragginScrollView) {
        self.yn_pageScrollViewBeginDragginScrollView(self);
    }
    
}

#pragma mark - Getter - Setter

- (BOOL)yn_observerDidScrollView {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setYn_observerDidScrollView:(BOOL)yn_observerDidScrollView {
    objc_setAssociatedObject(self, @selector(yn_observerDidScrollView), @(yn_observerDidScrollView), OBJC_ASSOCIATION_ASSIGN);
}

- (YNPageScrollViewDidScrollView)yn_pageScrollViewDidScrollView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setYn_pageScrollViewDidScrollView:(YNPageScrollViewDidScrollView)yn_pageScrollViewDidScrollView {
    objc_setAssociatedObject(self, @selector(yn_pageScrollViewDidScrollView), yn_pageScrollViewDidScrollView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (YNPageScrollViewBeginDragginScrollView)yn_pageScrollViewBeginDragginScrollView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setYn_pageScrollViewBeginDragginScrollView:(YNPageScrollViewBeginDragginScrollView)yn_pageScrollViewBeginDragginScrollView {
    objc_setAssociatedObject(self, @selector(yn_pageScrollViewBeginDragginScrollView), yn_pageScrollViewBeginDragginScrollView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma amrk - Swizzle
+ (void)swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector {
    Class cls = [self class];
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    if (class_addMethod(cls,
                        origSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        class_replaceMethod(cls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        class_replaceMethod(cls,
                            newSelector,
                            class_replaceMethod(cls,
                                                origSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
    }
}

- (void)yn_setContentOffsetY:(CGFloat)offsetY {
    if (self.contentOffset.y != offsetY) {
        self.contentOffset = CGPointMake(0, offsetY);
    }
}

@end
