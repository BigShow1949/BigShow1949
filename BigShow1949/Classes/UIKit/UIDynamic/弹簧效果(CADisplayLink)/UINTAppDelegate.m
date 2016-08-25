//
//  UINTAppDelegate.m
//  InteractiveAnimations
//
//  Created by Chris Eidhof on 02.05.14.
//  Copyright (c) 2014 Unsigned Integer. All rights reserved.
//

#import "UINTAppDelegate.h"
#import "UINTViewController.h"

@implementation UINTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINTViewController *viewController = [[UINTViewController alloc] init];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
