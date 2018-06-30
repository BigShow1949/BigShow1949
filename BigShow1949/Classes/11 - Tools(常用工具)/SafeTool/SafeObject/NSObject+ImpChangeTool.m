//
//  NSObject+ImpChangeTool.m
//  SafeObjectCrash
//
//  Created by lujh on 2018/4/18.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "NSObject+ImpChangeTool.h"
#import <objc/runtime.h>
@implementation NSObject (ImpChangeTool)
+ (void)SwizzlingMethod:(NSString *)systemMethodString systemClassString:(NSString *)systemClassString toSafeMethodString:(NSString *)safeMethodString targetClassString:(NSString *)targetClassString{
    //获取系统方法IMP
    Method sysMethod = class_getInstanceMethod(NSClassFromString(systemClassString), NSSelectorFromString(systemMethodString));
    //自定义方法的IMP
    Method safeMethod = class_getInstanceMethod(NSClassFromString(targetClassString), NSSelectorFromString(safeMethodString));
    //IMP相互交换，方法的实现也就互相交换了
    method_exchangeImplementations(safeMethod,sysMethod);
}
@end
