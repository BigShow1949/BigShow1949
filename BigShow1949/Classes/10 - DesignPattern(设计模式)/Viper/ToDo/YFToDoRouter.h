//
//  YFToDoRouter.h
//  BigShow1949
//
//  Created by big show on 2018/12/7.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFToDoProtocols.h"
#import "YFToDoViewController.h"
@interface YFToDoRouter : NSObject<ToDoWireframeProtocol>
@property (nonatomic, weak) YFToDoViewController *viewController;

+ (YFToDoViewController *)createModule;

@end
