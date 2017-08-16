//
//  RouterTool.m
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/5.
//  Copyright © 2017年 chenlei. All rights reserved.
//


#import "EcoRouterTool.h"
#import "EcoRouter.h"

#define  ROUTER_TABLE   @"RouterList"


@implementation EcoRouterTool

//注册
+ (void)load
{
    [self registerRouterListFromPlist:ROUTER_TABLE];
}


//获取路由表
+ (NSDictionary *)getRouterPlistName:(NSString *)fileName
{
    fileName = (fileName && ![fileName isKindOfClass:[NSNull class]]) ? fileName : @"";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSDictionary *routerDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return routerDic;
}

//注册Router表
+ (void)registerRouterListFromPlist:(NSString *)fileName
{
    NSDictionary *routerDic = [self getRouterPlistName:fileName];
    
    for (NSString *key in routerDic.allKeys)
    {
        [EcoRouter registerURLPattern:routerDic[key] toObjectHandler:^id(NSDictionary *routerParameters) {
            
            UIViewController *viewController = [[NSClassFromString(key) alloc] init];
            if ([viewController isKindOfClass:[UIViewController class]])
            {
                viewController.paramDic = routerParameters;
            }
            return viewController;
            
        }];
    }
}


//打开RouterLink
+ (UIViewController *)openUrl:(NSString *)url
{
   return [self openUrl:url withUserInfo:nil];
}

//打开RouterLink
+ (UIViewController *)openUrl:(NSString *)url withUserInfo:(NSDictionary *)userInfo
{
    return [EcoRouter objectForURL:url withUserInfo:userInfo];
}


//打开RouterLink自动跳转
+ (void)openUrl:(NSString *)url from:(UIViewController *)viewController
{
    [self openUrl:url withUserInfo:nil from:viewController];
}

//打开RouterLink自动跳转（通过classname）
+ (void)openClass:(NSString *)className withUserInfo:(NSDictionary *)userInfo from:(UIViewController *)viewController
{
    
    NSDictionary *routerDic = [self getRouterPlistName:ROUTER_TABLE];
    NSString *url = routerDic[className];
    [self openUrl:url withUserInfo:userInfo from:viewController];
}


//打开RouterLink自动跳转
+ (void)openUrl:(NSString *)url withUserInfo:(NSDictionary *)userInfo from:(UIViewController *)viewController
{
    if (![viewController isKindOfClass:[UIViewController class]] || !viewController)
    {
        return;
    }
    
    UIViewController *routerViewController = [EcoRouter objectForURL:url withUserInfo:userInfo];
    if ([routerViewController isKindOfClass:[UIViewController class]])
    {
        if ([viewController isKindOfClass:[UINavigationController class]])
        {
            [(UINavigationController *)viewController pushViewController:routerViewController animated:YES];
        }
        else
        {
            UINavigationController *routerNav = [[UINavigationController alloc] initWithRootViewController:routerViewController];
            [viewController presentViewController:routerNav animated:YES completion:^{
                
            }];
        }
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"未匹配到页面" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [viewController presentViewController:alertController animated:YES completion:^{
            
        }];
    }
}



@end
