//
//  AMapSearchError.h
//  AMapSearchKit
//
//  Created by xiaoming han on 15/7/29.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

#ifndef AMapSearchKit_AMapSearchError_h
#define AMapSearchKit_AMapSearchError_h

/** AMapSearch errorDomain */
extern NSString * const AMapSearchErrorDomain;

/** AMapSearch errorCode */
typedef NS_ENUM(NSInteger, AMapSearchErrorCode)
{
    AMapSearchErrorOK                       = 0, //!< 没有错误
    AMapSearchErrorUnknown                  = 1, //!< 未知错误
    AMapSearchErrorInvalidSCode             = 2, //!< 安全码验证错误
    AMapSearchErrorInvalidKey               = 3, //!< key非法或过期
    AMapSearchErrorInvalidService           = 4, //!< 请求服务不存在
    AMapSearchErrorInvalidResponse          = 5, //!< 请求服务响应错误
    AMapSearchErrorInsufficientPrivileges   = 6, //!< 无权限访问此服务
    AMapSearchErrorOverQuota                = 7, //!< 请求超出配额
    AMapSearchErrorInvalidParams            = 8, //!< 请求参数非法
    AMapSearchErrorInvalidProtocol          = 9, //!< 协议解析错误
    AMapSearchErrorKeyNotMatch              = 10, //!< 请求key与绑定平台不符
    AMapSearchErrorTooFrequently            = 11, //!< 用户访问过于频繁
    AMapSearchErrorInvalidUserIp            = 12, //!< 用户无效ip
    AMapSearchErrorInvalidUserSignature     = 13, //!< 用户无效签名
    AMapSearchErrorShortAddressFailed       = 14, //!< 短串转换失败
    
    AMapSearchErrorInvalidUserID            = 30, //!< 找不到对应userID的信息
    AMapSearchErrorKeyNotBind               = 31, //!< key未开通“附近”功能，请到管理台完成绑定
    AMapSearchErrorNotSupportHttps          = 32, //!< 不支持HTTPS请求
    AMapSearchErrorServiceMaintenance       = 33, //!< 服务器维护中
    AMapSearchErrorInvalidAccount           = 34, //!< 账号未激活或已被冻结

    AMapSearchErrorCancelled                = 100, //!< 连接取消
    AMapSearchErrorTimeOut                  = 101, //!< 连接超时
    AMapSearchErrorCannotFindHost           = 102, //!< 找不到主机
    AMapSearchErrorBadURL                   = 103, //!< URL异常
    AMapSearchErrorNotConnectedToInternet   = 104, //!< 连接异常
    AMapSearchErrorCannotConnectToHost      = 105, //!< 服务器连接失败
};

#endif
