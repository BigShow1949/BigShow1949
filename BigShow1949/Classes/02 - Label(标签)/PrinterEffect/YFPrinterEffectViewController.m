//
//  YFPrinterEffectViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/3/17.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFPrinterEffectViewController.h"
#import "ZTypewriteEffectLabel.h"

@interface YFPrinterEffectViewController ()

@end

@implementation YFPrinterEffectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    ZTypewriteEffectLabel *myLbl = [[ZTypewriteEffectLabel alloc] initWithFrame:CGRectMake(5, 30, 310, 450)];
    myLbl.tag = 10;
    myLbl.backgroundColor = [UIColor clearColor];
    myLbl.numberOfLines = 0;
    
    myLbl.text = @"\t\t\t打印机输出特效\n\n\tCode4App 是一个面向移动开发者的开源代码收集和分享网站。\n\n\t开发者可以方便找到自己需要的代码，减少在不同 App 开发过程中重复造车，大大提高开发效率。\n\n\tCode4App帮助开发者收集高质量的开源代码，并允许用户分享自己编写的代码。Code4App 会为每份代码做严格的模拟机和真机测试，并为每份代码配上文字说明、屏幕截屏效果图以及视频演示（如果需要）。同时，Code4App 允许用户自行上传代码分享给其他用户。调动开发者用户积极性的同时，充分的发挥了开源分享的精神。 \n\n\t\t\t\t\t\t\t\tBy\tZ ";
    
    myLbl.textColor = self.view.backgroundColor;
    
    
    myLbl.typewriteEffectColor = [UIColor greenColor];
    myLbl.hasSound = YES;
    myLbl.typewriteTimeInterval = 0.3;
    myLbl.typewriteEffectBlock = ^{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"打印完成" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    };
    
    [self.view addSubview:myLbl];
    
    
    /** Z
     *	1秒后开始打印输出
     */
    [self performSelector:@selector(startOutPut) withObject:nil afterDelay:1];
    
}


-(void)startOutPut
{
    ZTypewriteEffectLabel *myLbl = (ZTypewriteEffectLabel *)[self.view viewWithTag:10];
    [myLbl startTypewrite];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
