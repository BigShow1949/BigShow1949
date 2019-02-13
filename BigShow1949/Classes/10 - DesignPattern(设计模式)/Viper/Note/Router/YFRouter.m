//
//  YFRouter.m
//  BigShow1949
//
//  Created by big show on 2018/10/16.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFRouter.h"

@implementation YFRouter
+ (void)pushViewController:(UIViewController *)destination fromViewController:(UIViewController *)source animated:(BOOL)animated {
    NSParameterAssert([destination isKindOfClass:[UIViewController class]]);
    NSParameterAssert(source.navigationController);
    [source.navigationController pushViewController:destination animated:animated];
}

+ (void)popViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSParameterAssert(viewController.navigationController);
    [viewController.navigationController popViewControllerAnimated:animated];
}

+ (void)presentViewController:(UIViewController *)viewControllerToPresent fromViewController:(UIViewController *)source animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    NSParameterAssert(viewControllerToPresent);
    NSParameterAssert(source);
    [source presentViewController:viewControllerToPresent animated:animated completion:completion];
}

+ (void)dismissViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    NSParameterAssert(viewController);
    [viewController dismissViewControllerAnimated:animated completion:completion];
}

+ (UIViewController *)loginViewWithMessage:(NSString *)message delegate:(id<YFLoginViewDelegate>)delegate  {
    return nil;
}
@end
