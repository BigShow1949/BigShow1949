//
//  MyDataSource.h
//  test
//
//  Created by 杨帆 on 16/6/29.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>  

/**
 *  tableview 的 data source 抽出类
 */

typedef void (^cellBackBlock)(id cell , id data);

@interface MyDataSource : NSObject<UITableViewDataSource>


/**
 *  初始化方法
 *
 *  @param array      数据源
 *  @param identifier 重用标示 与 类名一致
 *
 *  @return 遵循了uitableview datasource 的对象， 并且实现了 datasource方法
 */
-(id)initWithItems:(NSArray *)array cellIdentifier:(NSString *)identifier andCallBack:cellBackBlock;

@end
