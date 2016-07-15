//
//  YFNotification.m
//  BigShow1949
//
//  Created by 杨帆 on 16/7/15.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFNotification.h"
/****************	YFNotification 	****************/
@implementation YFNotification
+ (YFNotification *)notificationWithObserver:(id)observer selector:(SEL)selector name:(nullable NSString *)aName object:(nullable id)anObject {
    
    YFNotification *notification = [[YFNotification alloc] init];
    notification.observer = observer;
    notification.name = aName;
    notification.object = anObject;
    notification.selector = selector;
    return notification;
}
@end



/****************	YFNotificationCenter	****************/

static YFNotificationCenter *_instance =nil;

@interface YFNotificationCenter ()
@property (nonatomic, strong) NSMutableArray *notiArr;
@end

@implementation YFNotificationCenter


- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSString *)aName object:(nullable id)anObject {
    
    YFNotification *noti = [YFNotification notificationWithObserver:observer selector:aSelector name:aName object:anObject];
    [self.notiArr addObject:noti];
}

- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject {
    for (YFNotification *noti in _notiArr) {
        if ([noti.name isEqualToString:aName]) {
            noti.object = anObject;
            [noti.observer performSelector:noti.selector withObject:noti];
        }
    }
}

- (void)removeObserver:(id)observer name:(nullable NSString *)aName object:(nullable id)anObject {
    for (YFNotification *noti in _notiArr) {
        if ([noti.name isEqualToString:aName] && [noti.name isEqual:observer]) {
            [self.notiArr removeObject:noti];
        }
    }
}

- (void)removeObserver:(id)observer {
    for (YFNotification *noti in _notiArr) {
        if ([noti.object isEqual:observer]) {
            [self.notiArr removeObject:noti];
        }
    }
}




#pragma mark - 单例
+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (YFNotificationCenter *)defaultCenter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark - 懒加载
- (NSMutableArray *)notiArr{
    if (!_notiArr) {
        _notiArr  =[NSMutableArray array];
    }
    return _notiArr;
}
@end
