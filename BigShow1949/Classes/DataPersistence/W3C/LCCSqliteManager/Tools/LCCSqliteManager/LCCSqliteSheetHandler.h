//
//  LCCSqliteSheetHandler.h
//  LCCSqliteManagerDemo
//
//  Created by LccLcc on 15/12/24.
//  Copyright © 2015年 LccLcc. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, LCCSheetReferencesType) {
    
    
    /*
     . cascade方式
     在父表上update/delete记录时，同步update/delete掉子表的匹配记录
     
     . No action方式
     如果子表中有匹配的记录,则不允许对父表对应候选键进行update/delete操作
     
     . Set default方式
     父表有变更时,子表将外键列设置成一个默认的值 但Innodb不能识别
     */
    
    LCCSqliteReferencesKeyTypeDefault = 0,  //父表有变更时,子表将外键列设置成一个默认的值 但Innodb不能识
    LCCSqliteReferencesKeyTypeCasCade = 1,  //在父表上update/delete记录时,同步update/delete掉子表的匹配记录
    LCCSqliteReferencesKeyTypeNoAction = 2,  //如果子表中有匹配的记录,则不允许对父表对应候选键进行update/delete操作
    
};

typedef NS_ENUM(NSInteger, LCCSheetType) {
    
    LCCSheetTypeTemperory = 0,//临时表
    LCCSheetTypeVariable = 1,//变量表
};


@interface LCCSqliteSheetHandler : NSObject

//本表类型
@property(nonatomic,assign)LCCSheetType sheetType;
//本表名
@property(nonatomic,strong)NSString *sheetName;
//本表字段
@property(nonatomic,strong)NSArray *sheetField;
//本表主键数组
@property(nonatomic,strong)NSArray *primaryKey;


//外键数组
@property(nonatomic,strong)NSArray *forgienKey;
//所依赖主表
@property(nonatomic,strong)NSString *referencesSheetName;
//所依赖主表主键
@property(nonatomic,strong)NSArray *referenceskey;
//依赖方式(主表有数据删除)
@property(nonatomic,assign)LCCSheetReferencesType deleateReferencesType;
//依赖方式(主表有数据更新)
@property(nonatomic,assign)LCCSheetReferencesType updateReferencesType;


//最终确定的sql语句
@property(nonatomic,strong)NSString *targetSql;

- (NSString *)returnTargetSql;

@end
