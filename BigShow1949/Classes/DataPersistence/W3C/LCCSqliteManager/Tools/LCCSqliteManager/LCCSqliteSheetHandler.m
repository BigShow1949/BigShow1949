//
//  LCCSqliteSheetHandler.m
//  LCCSqliteManagerDemo
//
//  Created by LccLcc on 15/12/24.
//  Copyright © 2015年 LccLcc. All rights reserved.
//

#import "LCCSqliteSheetHandler.h"


@implementation LCCSqliteSheetHandler
{
    NSString * _deleateTypeStr;
    NSString * _updateTypeStr;
}


- (instancetype)init{
    if (self = [super init]) {
        _targetSql = [[NSString alloc]init];
        //默认类型
        _sheetType = LCCSheetTypeVariable;
        _deleateReferencesType = LCCSqliteReferencesKeyTypeCasCade;
        _updateReferencesType = LCCSqliteReferencesKeyTypeCasCade;
    }
    
    return self;
}



- (NSString *)returnTargetSql{
    
    //预判断
    if (!_sheetName || !_sheetField) {
        NSLog(@"sql语句构建失败:缺少表名和字段");
        return nil;
    }
 
    
    //存放参数
    NSMutableArray *attributes = [[NSMutableArray alloc]init];
    
    //添加字段
    if (_sheetField) {
        for (int i = 0; i < _sheetField.count; i++) {
            NSString * att = [NSString stringWithFormat:@"\"%@\" TEXT",_sheetField[i]];
            [attributes addObject:att];
        }
    }

    //添加主键
    if (_primaryKey) {
        NSString* primaryKeyString = [[NSString alloc]init];
        for (int i = 0; i < _primaryKey.count; i++) {
            if (i==_primaryKey.count - 1) {
                primaryKeyString = [primaryKeyString stringByAppendingString:[NSString stringWithFormat:@" \"%@\" ",_primaryKey[i]]];
                break;
            }
            primaryKeyString = [primaryKeyString stringByAppendingString:[NSString stringWithFormat:@" \"%@\", ",_primaryKey[i]]];
        }
        [attributes addObject:[NSString stringWithFormat:@"PRIMARY KEY (%@)",primaryKeyString]];
    }
    
    //添加外键约束
    if ( _forgienKey&&_referenceskey&&_referencesSheetName) {
        if (_forgienKey.count != _referenceskey.count) {
            NSLog( @"sql语句构建失败:外键个数与依赖个数不匹配");
            return nil;
        }
        NSString * forengiKeyString = [[NSString alloc]init];
        NSString * referencesKeyString = [[NSString alloc]init];
        for (int i = 0; i < _forgienKey.count; i++) {
            if (i==_forgienKey.count - 1) {
                forengiKeyString = [forengiKeyString stringByAppendingString:[NSString stringWithFormat:@" \"%@\" ",_forgienKey[i]]];
                referencesKeyString = [referencesKeyString stringByAppendingString:[NSString stringWithFormat:@" \"%@\" ",_referenceskey[i]]];
                break;
            }
            forengiKeyString = [forengiKeyString stringByAppendingString:[NSString stringWithFormat:@" \"%@\", ",_forgienKey[i]]];
            referencesKeyString = [referencesKeyString stringByAppendingString:[NSString stringWithFormat:@" \"%@\", ",_referenceskey[i]]];
        }
        
        [self _referenceTypeJudge];
        [attributes addObject:[NSString stringWithFormat:@"FOREIGN KEY (%@) REFERENCES \"%@\" (%@) ON UPDATE %@ ON DELETE %@",forengiKeyString,_referencesSheetName,referencesKeyString,_updateTypeStr,_deleateTypeStr]];

    }
    
    NSString *_conditionString = [[NSString alloc]init];
    for (int i = 0 ; i < attributes.count; i ++) {
        if (i == attributes.count - 1) {
            _conditionString  = [_conditionString stringByAppendingString:[NSString stringWithFormat:@"%@\n",attributes[i]]];

            break;
        }
        _conditionString  = [_conditionString stringByAppendingString:[NSString stringWithFormat:@"%@,\n",attributes[i]]];
    }
    
    
    if (_sheetType == LCCSheetTypeTemperory) {
        _targetSql = [NSString stringWithFormat:@" CREATE TEMP TABLE \"%@\" (\n%@) ",_sheetName,_conditionString];
    }
    
    if (_sheetType == LCCSheetTypeVariable) {
        _targetSql = [NSString stringWithFormat:@" CREATE  TABLE \"%@\" (\n%@) ",_sheetName,_conditionString];
    }
    
    NSLog(@"最终的sql语句:\n %@",_targetSql);
    return _targetSql;
}


- (void)_referenceTypeJudge{
    
    switch (_deleateReferencesType) {
        case LCCSqliteReferencesKeyTypeCasCade:
            _deleateTypeStr = @"CASCADE";
            break;
        case LCCSqliteReferencesKeyTypeDefault:
            _deleateTypeStr = @"SET DEFAULT";
            break;
        case LCCSqliteReferencesKeyTypeNoAction:
            _deleateTypeStr = @"NO ACTION";
            break;

        default:
            break;
    }
    
    switch (_updateReferencesType) {
        case LCCSqliteReferencesKeyTypeCasCade:
            _updateTypeStr = @"CASCADE";
            break;
        case LCCSqliteReferencesKeyTypeDefault:
            _updateTypeStr = @"SET DEFAULT";
            break;
        case LCCSqliteReferencesKeyTypeNoAction:
            _updateTypeStr = @"NO ACTION";
            break;
            
        default:
            break;
    }

}

@end
