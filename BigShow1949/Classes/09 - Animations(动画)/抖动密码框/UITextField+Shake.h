//
//  UITextField+test.h
//  test2
//
//  Created by apple on 16/8/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UITextField (Shake)

- (void)shakeWithCompletion:(void (^)())completion;

@end
