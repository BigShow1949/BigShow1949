//
//  MenuItemCell.h
//  MutableMenuTableView
//
//  Created by 张国庆 on 16/4/27.
//  Copyright © 2016年 zgq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyItem.h"
@interface MenuItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (nonatomic,strong) MyItem *item;
-(void)setLevel:(NSInteger)level;
@end
