//
//  SecondViewController.h
//  MutableMenuTableView
//
//  Created by 张国庆 on 16/4/28.
//  Copyright © 2016年 zgq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyItem.h"

@interface SecondViewController : UIViewController

{
    BOOL flag[100];
    NSInteger oldindex;
}
@property (weak, nonatomic) IBOutlet UITableView *secondTableView;
@property (nonatomic,strong)MyItem *item;
@end
