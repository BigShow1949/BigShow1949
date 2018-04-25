//
//  NSMutableString+Safe.m
//  SafeObjectCrash
//
//  Created by lujh on 2018/4/18.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "NSMutableString+Safe.h"

#import <objc/runtime.h>
#import "NSObject+Swizzling.h"
#import "NSMutableString+Safe.h"

@implementation NSMutableString (Safe)

#pragma mark --- init method

+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 替换  substringFromIndex:
        NSString *tmpSubFromStr = @"substringFromIndex:";
        NSString *tmpSafeSubFromStr = @"safeMutable_substringFromIndex:";
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpSubFromStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeSubFromStr)];
        
        
        // 替换  substringToIndex:
        NSString *tmpSubToStr = @"substringToIndex:";
        NSString *tmpSafeSubToStr = @"safeMutable_substringToIndex:";
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpSubToStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeSubToStr)];
        
        
        // 替换  substringWithRange:
        NSString *tmpSubRangeStr = @"substringWithRange:";
        NSString *tmpSafeSubRangeStr = @"safeMutable_substringWithRange:";
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpSubRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeSubRangeStr)];
        
        
        
        // 替换  rangeOfString:options:range:locale:
        NSString *tmpRangeOfStr = @"rangeOfString:options:range:locale:";
        NSString *tmpSafeRangeOfStr = @"safeMutable_rangeOfString:options:range:locale:";
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpRangeOfStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeRangeOfStr)];
        
        
        // 替换  appendString
        NSString *tmpAppendStr = @"appendString:";
        NSString *tmpSafeAppendStr = @"safeMutable_appendString:";
        
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpAppendStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeAppendStr)];
        
        
    });
    
}


#pragma mark --- implement method
/****************************************  substringFromIndex:  ***********************************/
/**
 从from位置截取字符串 对应 __NSCFString
 
 @param from 截取起始位置
 @return 截取的子字符串
 */
- (NSString *)safeMutable_substringFromIndex:(NSUInteger)from {
    if (from > self.length ) {
        return nil;
    }
    return [self safeMutable_substringFromIndex:from];
}


/****************************************  substringFromIndex:  ***********************************/
/**
 从开始截取到to位置的字符串  对应  __NSCFString
 
 @param to 截取终点位置
 @return 返回截取的字符串
 */
- (NSString *)safeMutable_substringToIndex:(NSUInteger)to {
    if (to > self.length ) {
        return nil;
    }
    return [self safeMutable_substringToIndex:to];
}



/*********************************** rangeOfString:options:range:locale:  ***************************/
/**
 搜索指定 字符串  对应  __NSCFString
 
 @param searchString 指定 字符串
 @param mask 比较模式
 @param rangeOfReceiverToSearch 搜索 范围
 @param locale 本地化
 @return 返回搜索到的字符串 范围
 */
- (NSRange)safeMutable_rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToSearch locale:(nullable NSLocale *)locale {
    if (!searchString) {
        searchString = self;
    }
    
    if (rangeOfReceiverToSearch.location > self.length) {
        rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }
    
    if (rangeOfReceiverToSearch.length > self.length) {
        rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }
    
    if ((rangeOfReceiverToSearch.location + rangeOfReceiverToSearch.length) > self.length) {
        rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }
    
    
    return [self safeMutable_rangeOfString:searchString options:mask range:rangeOfReceiverToSearch locale:locale];
}



/*********************************** substringWithRange:  ***************************/
/**
 截取指定范围的字符串  对应  __NSCFString
 
 @param range 指定的范围
 @return 返回截取的字符串
 */
- (NSString *)safeMutable_substringWithRange:(NSRange)range {
    if (range.location > self.length) {
        return nil;
    }
    
    if (range.length > self.length) {
        return nil;
    }
    
    if ((range.location + range.length) > self.length) {
        return nil;
    }
    return [self safeMutable_substringWithRange:range];
}


/*********************************** safeMutable_appendString:  ***************************/
/**
 追加字符串 对应  __NSCFString
 
 @param aString 追加的字符串
 */
- (void)safeMutable_appendString:(NSString *)aString {
    if (!aString) {
        return;
    }
    return [self safeMutable_appendString:aString];
}
@end
