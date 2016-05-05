//
//  NSObject+KVC.h
//  CloudLabel
//
//  Created by PowerAuras on 13-9-6.
//  qq120971999  http://www.cnblogs.com/powerauras/
//  Copyright (c) 2013年 PowerAuras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface NSObject (aa)
- (id)valueForUndefinedKey:(NSString *)key;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
