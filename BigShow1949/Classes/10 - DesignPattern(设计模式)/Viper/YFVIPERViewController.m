//
//  YFVIPERViewController.m
//  BigShow1949
//
//  Created by big show on 2018/10/15.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFVIPERViewController.h"

@interface YFVIPERViewController ()

@end

@implementation YFVIPERViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDataArr:@[@[@"Counter计数器",@"YFCounterViewController_UIStoryboard"],
                         @[@"TableList",@"YFViperTableListViewController"],
                         @[@"ToDo",@"YFToDoBaseViewController"],
                         @[@"Note",@"YFNoteListViperViewController"] // 待完成
                         ]];
}

/*
 视图（V）：显示展示器的要求，并返回用户输入。
 视图通常是被动的。它显示展示器传输来的内容；却不能向展示器主动请求数据。为一个视图定义的方法（例如 LoginView 需要登录界面），应该允许展示器在更高的抽象级进行通信，展示器直接展示其内容，而不关心该内容要如何显示。展示器不知道 UILabel、UIButton 等控件，只知道维护内容以及显示时机。内容要如何展示完全取决于视图。
 
 交互器（P）：包含用例指定的业务逻辑。
 交互代表应用程序中的一个用例，它包含业务逻辑用来操纵模型对象（实体）以进行特定任务。交互器所做的工作应该是独立于任何用户界面的。同样的交互器可以在 iOS 应用或 OS X 应用中使用。
 
 展示器(I)：包含视图逻辑用于准备显示内容（从交互器接收的）并反馈用户输入（通过显示器请求最新数据）。
 展示器是一个 PONSO，主要由逻辑组成来驱动用户界面。它知道何时呈现用户界面，收集用户交互过程的输入，用于实时更新 UI，并像交互器发送响应请求。
 
 实体(E)：包含交互器所用的基本模型对象。
 实体是由交互器操纵的模型对象（仅由交互器操控），交互器不会将实体传递到表现层（即展示器）。
 
 路由(R)：包含导航逻辑来描述屏幕出现的顺序。
 界面之间的路由在交互设计师创建的线框中定义。在 VIPER 中，路由的任务是实现展示器和线框之间的共享。线框对象包括 UIWindow、UINavigationController 和 UIViewController 等，它负责创建视图/视图控制器，并在窗口中完成装配。
 由于展示器包含响应用户输入的逻辑，所以它知道何时该导航到其他屏幕，应导航到哪个界面，同时，线框知道如何进行导航。展示器主要使用线框实现导航功能。线框和展示器协同描述一个屏幕到下一个的路由的过程。
 */


@end
