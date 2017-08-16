//
//  UIViewController+Router.m
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/14.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import "UIViewController+Router.h"
#import <objc/runtime.h>

static const void *ParamDicKey = &ParamDicKey;

@implementation UIViewController (Router)

- (void)setParamDic:(NSDictionary *)paramDic
{
    objc_setAssociatedObject(self, ParamDicKey, paramDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)paramDic
{
    return objc_getAssociatedObject(self, ParamDicKey);
}

@end
