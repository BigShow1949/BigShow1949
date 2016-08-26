//
//  YFNotification.h
//  BigShow1949
//
//  Created by 杨帆 on 16/7/15.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN // 在这两个宏之间的代码，所有简单指针对象都被假定为nonnull，因此我们只需要去指定那些nullable的指针
// __nullable表示对象可以是NULL或nil，而__nonnull表示对象不应该为空。当我们不遵循这一规则时，编译器就会给出警告。

/****************	YFNotification	****************/
@interface YFNotification : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) id observer;
@property (nonatomic, strong) id object;
@property (nonatomic, assign) SEL selector;

+ (YFNotification *)notificationWithObserver:(id)observer selector:(SEL)selector name:(nullable NSString *)aName object:(nullable id)anObject;

@end


/****************	YFNotificationCenter	****************/

@interface YFNotificationCenter : NSObject


+ (YFNotificationCenter *)defaultCenter;

/**
 *  注册通知(同一个observer多次注册只算一次)
 *
 *  @param observer  监听者
 *  @param aSelector 调用方法
 *  @param aName     通知名字
 *  @param anObject  附带数据
 */
- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSString *)aName object:(nullable id)anObject;

- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject;
/**
 *  通知默认1对多,这个方法可以实现1对1
 *
 *  @param observer 消息接收者
 *  @param aName    通知消息
 *  @param anObject 附带数据
 */
- (void)postNotificationObserver:(id)observer name:(NSString *)aName object:(nullable id)anObject;

/**
 *  清除observer所有监听的消息
 *
 *  @param observer 监听对象
 */
- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer name:(nullable NSString *)aName object:(nullable id)anObject;


@end


NS_ASSUME_NONNULL_END
