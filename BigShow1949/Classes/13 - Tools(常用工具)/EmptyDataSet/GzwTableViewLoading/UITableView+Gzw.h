//
//  UITableView+Gzw.h
//  跑腿
//
//  Created by sky33 on 16/1/12.
//  Copyright © 2016年 paotui. All rights reserved.
//  处理tableView没数据时状态的分类（加载中也可以）

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

typedef void (^loadingBlock)();
@interface UITableView (Gzw)<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
/**
 *  是否在加载 YES:转菊花 or NO:立即空状态界面
 *  PS:在加载数据前设置为YES(必需)，随后根据数据调整为NO(可选)
 */
@property (nonatomic, assign)BOOL loading;



/**
 *  不加载状态下的图片(loading = NO)
 *  PS:空状态下显示图片
 */
@property (nonatomic, copy)NSString *loadedImageName;
@property (nonatomic, copy)NSString *descriptionText;// 空状态下的文字详情
/**
 *  刷新按钮文字
 */
@property (nonatomic, copy)NSString *buttonText;
@property (nonatomic,strong) UIColor *buttonNormalColor;// 按钮Normal状态下文字颜色
@property (nonatomic,strong) UIColor *buttonHighlightColor;// 按钮Highlight状态下文字颜色


/**
 *  视图的垂直位置
 *  PS:tableView中心点为基准点,(基准点＝0)
 */
@property (nonatomic, assign)CGFloat dataVerticalOffset;




@property(nonatomic,copy)loadingBlock loadingClick;// 点击回调block的属性
/**
 *  点击回调方法：跟loadingClick属性效果一样的
 *
 *  @param block 要执行的操作
 */
-(void)gzwLoading:(loadingBlock)block;
@end
