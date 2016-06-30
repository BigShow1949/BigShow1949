//
//  MyBaseDataSource.h
//  BigShow1949
//
//  Created by 杨帆 on 16/6/30.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^YFCellSelectedBlock)(id obj);
typedef void (^YFCellBackBlock)(id cell , id data);

@interface MyBaseDataSource : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) NSString *cellIdentifier;               // cell样式选择
@property (nonatomic, copy) NSArray *serverData;                     // cell数据
@property (nonatomic, copy) YFCellSelectedBlock cellSelectedBlock;   // cell点击事件
@property (nonatomic, copy) YFCellBackBlock cellBackBlock; // 如果cell不想装配model,可以交给控制器处理
/**
 *  初始化dataSource
 *
 *  @param serverData  服务器返回数据
 *  @param identifiers cell类型
 *
 *  @return Datasource
 */
- (id)initWithServerData:(NSArray *)serverData
       andCellIdentifier:(NSString *)identifier;

@end
