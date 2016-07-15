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

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSString *)aName object:(nullable id)anObject;

- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject;

- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer name:(nullable NSString *)aName object:(nullable id)anObject;


@end


NS_ASSUME_NONNULL_END
