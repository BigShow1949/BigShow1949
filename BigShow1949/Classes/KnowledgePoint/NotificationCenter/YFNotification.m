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

- (NSString *)description {

    return [NSString stringWithFormat:@"observer:%@, name:%@", self.observer, self.name];
}
@end



/****************	YFNotificationCenter	****************/

static YFNotificationCenter *_instance =nil;

@interface YFNotificationCenter ()
@property (nonatomic, strong) NSMutableArray *notiArr;
@end

@implementation YFNotificationCenter

#pragma mark - 监听
- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSString *)aName object:(nullable id)anObject {
    
    if (!observer || !aSelector) return;
    
    BOOL isContain = NO;
    for (YFNotification *noti in _notiArr) {
        if ([noti.observer isEqual:observer] && [noti.name isEqualToString:aName]) {
            isContain = YES;
        }
    }
    
    if (!isContain) {
        YFNotification *noti = [YFNotification notificationWithObserver:observer selector:aSelector name:aName object:anObject];
        [self.notiArr addObject:noti];
    }
}

#pragma mark - 发通知
- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject {
    if (!aName) return;
    
    for (YFNotification *noti in _notiArr) {
        if ([noti.name isEqualToString:aName]) {
            noti.object = anObject;
            [noti.observer performSelector:noti.selector withObject:noti];
        }
    }
}

- (void)postNotificationObserver:(id)observer name:(NSString *)aName object:(nullable id)anObject {
    if (!aName || !observer) return;

    for (YFNotification *noti in _notiArr) {
        if ([noti.name isEqualToString:aName] && [noti.observer isEqual:observer]) {
            noti.object = anObject;
            [noti.observer performSelector:noti.selector withObject:noti];
            break;  // 1个observer只能注册一遍一个aName,所以可以终止循环了
        }
    }
}

#pragma mark - 接收通知
- (void)removeObserver:(id)observer name:(nullable NSString *)aName object:(nullable id)anObject {
    for (YFNotification *noti in _notiArr) {
        if ([noti.name isEqualToString:aName] && [noti.observer isEqual:observer]) {
            [self.notiArr removeObject:noti];
        }
    }
}

- (void)removeObserver:(id)observer {
//    NSLog(@"_notiArr = %@", _notiArr);
    NSMutableArray *tempNotiArr = [NSMutableArray arrayWithArray:_notiArr];
    for (YFNotification *noti in tempNotiArr) {
        if ([noti.observer isEqual:observer]) {
            [_notiArr removeObject:noti];
        }
    }
//    NSLog(@"_notiArr = %@", _notiArr);
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
