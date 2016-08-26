//
//  UIImage+Image.m
//  BigShow1949
//
//  Created by 杨帆 on 16/7/6.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "UIImage+Image.h"
#import <objc/runtime.h>
@implementation UIImage (Image)
// 加载分类到内存的时候调用
+ (void)load
{
//    // 交换方法
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        SEL selA = @selector(imageNamed:);
//        SEL selB = @selector(imageWithName:); // B是自己定义的方法
//        Method methodA =   class_getInstanceMethod(self,selA);
//        Method methodB = class_getInstanceMethod(self, selB);
//        BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
//        if (isAdd) {
//            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
//        }else{
//            method_exchangeImplementations(methodA, methodB);
//        }
//    });
    

    
    // 获取imageWithName方法地址
    Method imageWithName = class_getClassMethod(self, @selector(imageWithName:));
    
    // 获取imageWithName方法地址
    Method imageName = class_getClassMethod(self, @selector(imageNamed:));
    
    // 交换方法地址，相当于交换实现方式
    method_exchangeImplementations(imageWithName, imageName);
    
}


// 不能在分类中重写系统方法imageNamed，因为会把系统的功能给覆盖掉，而且分类中不能调用super.

// 既能加载图片又能打印
+ (instancetype)imageWithName:(NSString *)name
{
    
    // 这里调用imageWithName，相当于调用imageName
    UIImage *image = [self imageWithName:name];
    
    if (image == nil) {
        NSLog(@"ERROR:加载空的图片");
    }
    
    return image;
}

@end
