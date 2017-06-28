//
//  JSCoreViewController.h
//  BigShow1949
//
//  Created by apple on 17/6/28.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface JSCoreViewController : UIViewController
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, weak) JSContext *context;

@end
