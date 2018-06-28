//
//  Person_Msg.m
//  BigShow1949
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "Person_Msg.h"

#import <objc/runtime.h>
#import "Car_Msg.h"

@implementation Person_Msg
/**
 *  首先，该方法在调用时，系统会查看这个对象能否接收这个消息（查看这个类有没有这个方法，或者有没有实现这个方法。），如果不能并且只在不能的情况下，就会调用下面这几个方法，给你“补救”的机会，你可以先理解为几套防止程序crash的备选方案，我们就是利用这几个方案进行消息转发，注意一点，前一套方案实现了,后一套方法就不会执行。如果这几套方案你都没有做处理，那么程序就会报错crash。
 
 方案一：
 
 + (BOOL)resolveInstanceMethod:(SEL)sel
 + (BOOL)resolveClassMethod:(SEL)sel
 
 方案二：
 
 - (id)forwardingTargetForSelector:(SEL)aSelector
 
 方案三：
 
 - (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;
 - (void)forwardInvocation:(NSInvocation *)anInvocation;
 
 */

void run (id self, SEL _cmd)
{
    // 程序会走我们C语言的部分
    NSLog(@"person:%@ %s", self, sel_getName(_cmd));
}


/**
 *   方案一
 *   动态方法解析(Dynamic Method Resolution或Lazy method resolution):向当前类(Class)发送resolveInstanceMethod:(对于类方法则为resolveClassMethod:)消息，如果返回YES,则系统认为请求的方法已经加入到了，则会重新发送消息。
 *   为Person类动态增加了run方法的实现, 由于没有实现run对应的方法, 那么系统会调用resolveInstanceMethod让你去做一些其他操作
 */
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//
//    if(sel == @selector(run)) {
//        NSLog(@"调用了======方案1");
//        class_addMethod([self class], sel, (IMP)run, "v@:");
//        return YES;
//    }
//    return [super respondsToSelector:sel];
//}

/** 方案二
 *  快速转发路径(Fast forwarding path):若果当前target实现了forwardingTargetForSelector:方法,则调用此方法。如果此方法返回除nil和self的其他对象，则向返回对象重新发送消息。
 *  现在不对方案一做任何的处理, 直接调用父类的方法, 系统会走到forwardingTargetForSelector方法
 */
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    NSLog(@"调用了======方案2");
//    return [[Car_Msg alloc] init];
//}


/**
 *   不实现forwardingTargetForSelector,
 系统就会调用方案三的两个方法
 methodSignatureForSelector 和 forwardInvocation
 */

/**
 *  方案三
 *  慢速转发路径(Normal forwarding path):首先runtime发送methodSignatureForSelector:消息查看Selector对应的方法签名，即参数与返回值的类型信息。如果有方法签名返回，runtime则根据方法签名创建描述该消息的NSInvocation，向当前对象发送forwardInvocation:消息，以创建的NSInvocation对象作为参数；若methodSignatureForSelector:无方法签名返回，则向当前对象发送doesNotRecognizeSelector:消息,程序抛出异常退出。
 *
 *  开头我们要找的错误unrecognized selector sent to instance原因，原来就是因为methodSignatureForSelector这个方法中，由于没有找到run对应的实现方法，所以返回了一个空的方法签名，最终导致程序报错崩溃。
 
 所以我们需要做的是自己新建方法签名，再在forwardInvocation中用你要转发的那个对象调用这个对应的签名，这样也实现了消息转发。
 */

/**
 *  methodSignatureForSelector
 *  用来生成方法签名, 这个签名就是给forwardInvocation中参数NSInvocation调用的
 *
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSString *sel = NSStringFromSelector(aSelector);
    // 判断你要转发的SEL
    if ([sel isEqualToString:@"run"]) {
        // 为你的转发方法手动生成签名
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
        
    }
    return [super methodSignatureForSelector:aSelector];
}
/**
 *  关于生成签名类型"v@:"解释一下, 每个方法会默认隐藏两个参数, self, _cmd
 self 代表方法调用者, _cmd 代表这个方法SEL, 签名类型就是用来描述这个方法的返回值, 参数的,
 v代表返回值为void, @表示self, :表示_cmd
 */
-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL selector = [anInvocation selector];
    // 新建需要转发消息的对象
    Car_Msg *car = [[Car_Msg alloc] init];
    if ([car respondsToSelector:selector]) {
        // 唤醒这个方法
        [anInvocation invokeWithTarget:car];
    }
}

@end
