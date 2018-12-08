//
//  YFToDoWireframe.m
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFToDoWireframe.h"

@implementation YFToDoWireframe
- (void)pushViewController:(UIViewController *)destination fromViewController:(UIViewController *)source {
    [source.navigationController pushViewController:destination animated:YES];
}
- (void)presentListInterfaceFromVC:(UIViewController *)vc {
    
}
@end
