//
//  RouterTool.h
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/5.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIViewController+Router.h"

@interface EcoRouterTool : NSObject

/**
 *  获取路由表
 *
 *  @param fileName plist文件名字
 *
 *  @return 路由表
 */
+ (NSDictionary *)getRouterPlistName:(NSString *)fileName;

/**
 *  通过Plist批量注册RouterUrl
 *
 *  @param fileName plist文件名字
 */

+ (void)registerRouterListFromPlist:(NSString *)fileName;

/**
 *  打开RouterLink
 *
 *  @param url 路由地址
 *
 *  @return UIViewController
 */

+ (UIViewController *)openUrl:(NSString *)url;

/**
 *  打开RouterLink
 *
 *  @param url      路由地址
 *  @param userInfo 参数
 *
 *  @return UIViewController
 */

+ (UIViewController *)openUrl:(NSString *)url withUserInfo:(NSDictionary *)userInfo;

/**
 *  打开RouterLink自动跳转（通过URL，不带UserInfo）
 *
 *  @param url              路由地址
 *  @param viewController   使用该方法的对象根试图（导航器或控制器）
 *
 */
+ (void)openUrl:(NSString *)url from:(UIViewController *)viewController;

/**
 *  打开RouterLink自动跳转（通过classname）
 *
 *  @param className        跳转类类名
 *  @param userInfo         参数
 *  @param viewController   使用该方法的对象根试图（导航器或控制器）
 *
 */
+ (void)openClass:(NSString *)className withUserInfo:(NSDictionary *)userInfo from:(UIViewController *)viewController;

/**
 *  打开RouterLink自动跳转（通过URL，带UserInfo）
 *
 *  @param url              路由地址
 *  @param viewController   使用该方法的对象根试图（导航器或控制器）
 *
 */
+ (void)openUrl:(NSString *)url withUserInfo:(NSDictionary *)userInfo from:(UIViewController *)viewController;


@end
