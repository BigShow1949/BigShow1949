//
//  YFRotateButtonViewController.m
//  BigShow1949
//
//  Created by WangMengqi on 15/9/2.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

// 注意:这里没有适配
#define kDelta 20
#import "YFRotateButtonViewController.h"

@interface YFRotateButtonViewController ()

@end

@implementation YFRotateButtonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //   UIButton *btn =  [[UIButton alloc] init];
    ////    NSString *str = ;
    //    btn.transform  = cgaf;
    //    NSLog(@"%@",btn);
    
}

- (IBAction)run:sende
{
    //    [UIView beginAnimations:Nil context:nil];
    //    [UIView setAnimationDuration:0.5];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect tempFrame = _btn.frame;
        int tag = [sende tag];
        switch (tag) {
            case 1:
                tempFrame.origin.y -= kDelta;
                break;
            case 2:
                tempFrame.origin.x += kDelta;
                break;
            case  3: // 下
                tempFrame.origin.y += kDelta;
                break;
                
            case 4: // 左
                tempFrame.origin.x -= kDelta;
                break;
                
            default:
                break;
        }
        _btn.frame = tempFrame;
        
    }];
    //    [UIView commitAnimations];
}
- (IBAction)scale:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat scale = [sender tag] == 20 ? 1.2 : 0.8;
        _btn.transform = CGAffineTransformScale(_btn.transform, scale, scale);
        
    }];
    // bounds方法时，center是不变的
    // frame方法时,左上角不变
    
}

// 旋转
- (IBAction)rotate:(id)sender {
    
    // 向左旋转45°
    //    _btn.transform = CGAffineTransformMakeRotation(- M_PI_4);
    //    _btn.transform = CGAffineTransformRotate(_btn.transform, M_PI_4 * (10 == tag?-1:1));
    int tag = [sender tag];
    if (10 == tag)
        _btn.transform = CGAffineTransformRotate(_btn.transform, M_PI_4 * -1);
    else
        _btn.transform = CGAffineTransformRotate(_btn.transform, M_PI_2);
    // M_PI 360°，M_PI_4可以理解为除以4
    
    /*
     // 原始数据总是不变，只修改一次
     CGAffineTransformMakeTranslation(CGFloat tx, <#CGFloat ty#>);
     
     // 在上一次的数据的基础上修改
     CGAffineTransformTranslate(<#CGAffineTransform t#>, <#CGFloat tx#>, <#CGFloat ty#>)
     缩放跟旋转都是一样的，注意没有Make的区别
     
     */
}


@end
