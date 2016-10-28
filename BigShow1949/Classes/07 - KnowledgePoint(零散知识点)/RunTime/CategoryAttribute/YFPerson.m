//
//  YFPerson.m
//  BigShow1949
//
//  Created by zhht01 on 16/4/14.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFPerson.h"
#import <objc/runtime.h>
@implementation YFPerson

-(void)run{
    NSLog(@"%s",__func__);
}

/*------------------- KVC字典转模型  ----------------------------*/
+ (instancetype)personWithDict:(NSDictionary *)dict
{
    YFPerson *person = [[self alloc] init];
    
    [person setValuesForKeysWithDictionary:dict];
    
    return person;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"value = %@, key = %@", value, key);
    if ([key isEqualToString:@"userName"]) {
        self.name = value;
    }
    
}


/*------------------------ 下面是动态添加方法------------------------------*/
/**
 默认一个方法都有两个参数，self，_cmd,为隐式参数，不显示
 self ：方法的调用者
 _cmd ：调用方法的编号，即方法名
 */
// void(*)()
// 默认方法都有两个隐式参数，
void test_eat(id self,SEL sel)
{
    NSLog(@"没有实现eat方法, 调用了test_eat方法");
}

// 当一个对象调用未实现的方法，会调用这个方法处理,并且会把对应的方法列表传过来.
// 刚好可以用来判断，未实现的方法是不是我们想要动态添加的方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    
    if (sel == @selector(eat)) {
        // 动态添加eat方法
        
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        class_addMethod(self, @selector(eat), test_eat, "v@:");
        
    }
    
    return [super resolveInstanceMethod:sel];
}

@end
