//
//  DataUpdateView.h
//  DatabaseMangerDemo
//
//  Created by LccLcc on 15/12/11.
//  Copyright © 2015年 LccLcc. All rights reserved.
//  更新数据页面

#import "DataInsertView.h"

@protocol DataUpdateViewDelegate <NSObject>

//更新失败
- (void)updateError;
//更新成功
- (void)updateSuccess;
//关闭
- (void)closeUpdateView;

@end


@interface DataUpdateView : UIView



@property(nonatomic,strong)NSString *sheetTitle;

@property(nonatomic,weak)id<DataUpdateViewDelegate>delegate;

//更新条件
@property(nonatomic,strong)NSString *updateCondition;  // condition

// 需要更新的数组
@property (nonatomic, strong) NSArray *updateArray;




@end
