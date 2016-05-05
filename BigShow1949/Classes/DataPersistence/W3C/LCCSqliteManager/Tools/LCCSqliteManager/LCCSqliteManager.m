//
//  LCCSqliteManager.m
//  LCCSqliteManagerDemo
//
//  Created by LccLcc on 15/11/25.
//  Copyright © 2015年 LccLcc. All rights reserved.
//

#import "LCCSqliteManager.h"

@implementation LCCSqliteManager
{

    sqlite3 *_sqlite ;
    
}



+ (LCCSqliteManager *)shareInstance{
    
    static LCCSqliteManager *instance = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        instance = [[[self class ]alloc ]init];
    });
    
    return instance;

}



#pragma mark - 数据库信息查询
+ (NSString*)sqliteLibVersion {
    return [NSString stringWithFormat:@"%s", sqlite3_libversion()];
}


+ (BOOL)isSqliteThreadSafe {
    return sqlite3_threadsafe() != 0;
}




#pragma mark - 数据库操作
- (BOOL)openSqliteFile:(NSString *)filename{
    
    if (_sqlite) {
        NSLog(@"error:目前暂时只支持同时打开一个数据库文件，请先关闭当前正在运行的文件");
        return YES;
    }
    if (!filename) {
        NSLog(@"error:请输入正确的文件名");
        return NO;
    }

    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat: @"/Documents/%@.sqlite", filename];
    int result = sqlite3_open([filePath UTF8String], &_sqlite);
    if (result != SQLITE_OK) {
        NSLog(@"error:数据库%@打开失败",filename);
        return NO;
    }
    

    NSLog(@"数据库%@打开成功,路径为:%@",filename,filePath);
    [self openForeignkey];
    return YES;

}



- (BOOL)closeSqliteFile{
    
    if (!_sqlite) {
        return YES;
    }

    int  result;
    BOOL retry;
    BOOL triedFinalizingOpenStatements = NO;
    
    do {
        retry   = NO;
        result  = sqlite3_close(_sqlite);
        if (SQLITE_BUSY == result || SQLITE_LOCKED == result) {
            if (!triedFinalizingOpenStatements) {
                triedFinalizingOpenStatements = YES;
                sqlite3_stmt *pStmt;
                while ((pStmt = sqlite3_next_stmt(_sqlite, nil)) !=0) {
                    NSLog(@"Closing leaked statement");
                    sqlite3_finalize(pStmt);
                    retry = YES;
                }
            }
        }
        else if (result != SQLITE_OK ) {
            NSLog(@"error closing!: %d", result);
        }
    }
    while (retry);
    _sqlite = nil;

    
    return YES;
    
}




- (BOOL)deleateSqliteFile:(NSString *)filename{
    
    [self closeSqliteFile];
    
    NSFileManager * fileManager = [[NSFileManager alloc]init];
    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat: @"/Documents/%@.sqlite", filename];
    NSError *error = nil;
    [fileManager removeItemAtPath:filePath error:&error];
    if (error) {
        NSLog(@"数据库删除失败:%@",error);
        return NO;
    }
    NSLog(@"数据库%@删除成功",filename);
    return YES;
}






#pragma mark - 数据表操作
- (NSArray *)getAllSheetNames{
    
    if (!_sqlite) {
        NSLog(@"error:请先打开数据库文件");
        return nil;
    }
    NSMutableArray *allSheetTitles = [[NSMutableArray alloc]init];
    
    sqlite3_stmt *statement;
    const char *getTableInfo = "SELECT * FROM sqlite_master WHERE type='table' ORDER by name";
    
    int result = sqlite3_prepare_v2(_sqlite, getTableInfo, -1, &statement, nil);
    if (result != SQLITE_OK) {
        NSLog(@"error:编译失败，请检查");
        return nil;
    }
    
    while (sqlite3_step(statement) == SQLITE_ROW) {
        char *nameData = (char *)sqlite3_column_text(statement, 1);
        NSString *tableName = [[NSString alloc] initWithUTF8String:nameData];
        [allSheetTitles addObject:tableName];
    }
    
    return allSheetTitles;
    
}




- (BOOL)createSheetWithName:(NSString *)pName attributes:(NSArray *)pAttributes primaryKey:(NSString *)pkey{
    
    
    if (!pName || !pAttributes) {
        NSLog(@"error:缺少表名或字段");
        return NO;
    }
    
    if (pAttributes.count == 0) {
        NSLog(@"error:字段数为0");
        return NO;
    }
    
    //重构数组
    NSMutableArray *attributes = [[NSMutableArray alloc]init];
    for (int i = 0; i < pAttributes.count; i++) {
        NSString * att = [NSString stringWithFormat:@"\"%@\" TEXT",pAttributes[i]];
        [attributes addObject:att];
    }
    if (pkey) {
        [attributes addObject:[NSString stringWithFormat:@"PRIMARY KEY (\"%@\")",pkey]];
    }
    //构造SQL语句，创建数据库表。
    NSString *appendString = [[NSString alloc]init];
    for (int i = 0 ; i < attributes.count; i ++) {
        if (i == attributes.count - 1) {
            appendString  = [appendString stringByAppendingString:attributes[i]];
            break;
        }
       appendString  = [appendString stringByAppendingString:[NSString stringWithFormat:@"%@,",attributes[i]]];
    }
    
    NSString *targetSql = [NSString stringWithFormat:@"CREATE TABLE \"%@\"(%@)",pName,appendString];
    NSLog(@"创建数据库表的sql语句 = %@",targetSql);
    
    //执行SQL语句
    char *error = NULL;
    int result = sqlite3_exec(_sqlite, [targetSql UTF8String], NULL, NULL, &error);
    if (result != SQLITE_OK) {
        NSLog(@"创建表失败:%s", error);
        return NO;
    }

    NSLog(@"创建表成功");
    return YES;

}




- (BOOL)createSheetWithName:(NSString *)pName attributes:(NSArray *)pAttributes primaryKey:(NSString *)pKey referenceSheet:(NSString *)oldName referenceType:(LCCSheetReferencesType)type{
    //新表判断
    if (!pName || !pAttributes) {
        NSLog(@"error:缺少表名或字段");
        return NO;
    }
    
    if (pAttributes.count == 0) {
        NSLog(@"error:字段数为0");
        return NO;
    }
    //旧表判断,如果旧表没有主键，返回
    NSArray *oldSheetPK = [self getSheetPrimaryKeyWithSheet:oldName];
    NSLog(@"%@",oldSheetPK);
    if (!oldSheetPK) {
        NSLog(@"error:必须依赖一张有主键的表");
        return NO;
    }
    
    //重构数组
    NSMutableArray *attributes = [[NSMutableArray alloc]init];
    NSString *typeStr = @"CASCADE";
    for (int i = 0; i < pAttributes.count; i++) {
        
        NSString * att = [NSString stringWithFormat:@"\"%@\" TEXT",pAttributes[i]];
        if (  [pKey isEqualToString: pAttributes[i]] ) {
            att = [NSString stringWithFormat:@"\"%@\" TEXT PRIMARY KEY REFERENCES \"%@\" (\"%@\") ON DELETE %@",pAttributes[i],oldName,oldSheetPK,typeStr];
        }
        [attributes addObject:att];
    }
    
    //构造SQL语句，创建数据库表。
    NSString *appendString = [[NSString alloc]init];
    for (int i = 0 ; i < pAttributes.count; i ++) {
        if (i == pAttributes.count - 1) {
            appendString  = [appendString stringByAppendingString:attributes[i]];
            break;
        }
        appendString  = [appendString stringByAppendingString:[NSString stringWithFormat:@"%@,",attributes[i]]];
    }
    
    NSString *targetSql = [NSString stringWithFormat:@"CREATE TABLE \"%@\"(%@)",pName,appendString];
    NSLog(@"创建数据库表的sql语句 = %@",targetSql);
    
    //执行SQL语句
    char *error = NULL;
    int result = sqlite3_exec(_sqlite, [targetSql UTF8String], NULL, NULL, &error);
    if (result != SQLITE_OK) {
        NSLog(@"创建表失败:%s", error);
        return NO;
    }
    
    NSLog(@"创建表成功");
    return YES;

    
}



- (BOOL)createSheetWithSheetHandler:(void (^)(LCCSqliteSheetHandler *))sheetHandler{
    
    LCCSqliteSheetHandler *sheet = [[LCCSqliteSheetHandler alloc]init];
    sheetHandler(sheet);
    
    NSString *targetSql = [sheet returnTargetSql];
    
    if (!targetSql) {
        return NO;
    }
    
    //执行SQL语句
    char *error = NULL;
    int result = sqlite3_exec(_sqlite, [targetSql UTF8String], NULL, NULL, &error);
    if (result != SQLITE_OK) {
        NSLog(@"创建表失败:%s", error);
        return NO;
    }
    
    NSLog(@"创建表成功");
    return YES;
    
    
}




- (BOOL)deleateSheetWithName:(NSString *)pName{
    
    if (!pName) {
        NSLog(@"error:名字为nil");
        return NO;
    }
    
    //构造sql语句
     NSString *targetSql = [NSString stringWithFormat:@"DROP TABLE \"%@\"",pName];
    //执行SQL语句
    char *error = NULL;
    int result = sqlite3_exec(_sqlite, [targetSql UTF8String], NULL, NULL, &error);
    if (result != SQLITE_OK) {
        NSLog(@"删除表失败:%s", error);
        return NO;
    }
    NSLog(@"删除表成功");
    return YES;
    
}


- (NSArray *)getSheetAttributesWithSheet:(NSString *)pName{
    
    if (!pName) {
        NSLog(@"error:名字为nil");
        return nil;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    sqlite3_stmt *ppStmt;
    NSString *targetSql = [NSString stringWithFormat:@"PRAGMA table_info(\"%@\")",pName];
    const char *getTableInfo = [targetSql UTF8String];
    
    //预编译
    sqlite3_prepare_v2(_sqlite, getTableInfo, -1, &ppStmt, nil);
    while (sqlite3_step(ppStmt) == SQLITE_ROW) {
        //逐行记录第一列的信息,其他几列存放了表的一些其他信息,暂时用不到
        char *nameData = (char *)sqlite3_column_text(ppStmt, 1);
        NSString *attributeName = [[NSString alloc] initWithUTF8String:nameData];
        [array addObject:attributeName];
    }
    
    NSLog(@"读取数据成功");
    return array;
    
}

- (NSInteger )getSheetAttributesCountWithSheet:(NSString *)pName{
    
    NSInteger count = [self getSheetAttributesWithSheet:pName].count;
    return count;
    
}

- (NSArray *)getSheetPrimaryKeyWithSheet:(NSString *)pName{
    
    if (!pName) {
        NSLog(@"error:名字为nil");
        return nil;
    }
    
    
    sqlite3_stmt *ppStmt;
    NSString *targetSql = [NSString stringWithFormat:@"PRAGMA table_info(\"%@\")",pName];
    const char *getTableInfo = [targetSql UTF8String];
    
    //预编译
    NSMutableArray *primaryKey = [NSMutableArray array];
    sqlite3_prepare_v2(_sqlite, getTableInfo, -1, &ppStmt, nil);
    while (sqlite3_step(ppStmt) == SQLITE_ROW) {
        
        char *nameData = (char *)sqlite3_column_text(ppStmt, 1);
        char *isPrimaryKey = (char *)sqlite3_column_text(ppStmt, 5);
        NSString *attributeName = [[NSString alloc] initWithUTF8String:nameData];
        NSString *isPK = [[NSString alloc] initWithUTF8String:isPrimaryKey];
        if ( ![isPK isEqualToString:@"0"]) {
            [primaryKey addObject:attributeName];
        }
        
    }
    NSLog(@"主键数组 = %@",primaryKey);
    return primaryKey;
    
}



- (NSArray *)getSheetDataWithSheet:(NSString *)pName{
    
    NSMutableArray *dataArray = [NSMutableArray array];
    NSInteger count = [self getSheetAttributesWithSheet:pName].count;
    NSLog(@"这个表有%ld个字段",(long)count);
    
    //预编译sql语句
    NSString *targetsql = [NSString stringWithFormat:@"SELECT * FROM \"%@\" ",pName] ;
    sqlite3_stmt *ppStmt = NULL;
    int result = sqlite3_prepare_v2(_sqlite, [targetsql UTF8String], -1, &ppStmt, NULL);
    if (result != SQLITE_OK) {
        NSLog(@"预编译失败");
        return nil;
    }
    
    //执行查询语句
    int hasData = sqlite3_step(ppStmt);
    //代表当前有一行数据
    while (hasData == SQLITE_ROW) {
        const  unsigned char *str;
        NSMutableArray *dataModel = [NSMutableArray array];
        for (int i = 0 ; i < count; i++) {
            str = sqlite3_column_text(ppStmt, i); //读出数据的每一列内容
            if (str == NULL) {
                [dataModel addObject:@""];
            }
            else{
                [dataModel addObject:[NSString stringWithUTF8String:(const char*)str]];
            }
            
        }
        //把数据加入到数组中
        [dataArray addObject:dataModel];
        //指向下一行
        hasData = sqlite3_step(ppStmt);
        
    }
    NSLog(@"读取数据成功,当前表内数据  = %@",dataArray);
    //手动释放内存
    sqlite3_finalize(ppStmt);
    return dataArray;

}

- (NSInteger )getSheetDataCountWithSheet:(NSString *)pName{
    
    NSInteger count = [self getSheetDataWithSheet:pName].count;
    return count;
    
}

- (void)copySheetWithSheet:(NSString *)sheetName{
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

- (BOOL)addColumnToSheet:(NSString *)sheetName withAttribute:(NSString *)attribute{
    
    
    if (!sheetName) {
        NSLog(@"error:名字为nil");
        return NO;
    }
    
    //构造sql语句  // ALTER TABLE t_parking ADD cost date
    NSString *targetSql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ TEXT DEFAULT ''", sheetName, attribute];

    //执行SQL语句
    char *error = NULL;
    int result = sqlite3_exec(_sqlite, [targetSql UTF8String], NULL, NULL, &error);
    if (result != SQLITE_OK) {
        NSLog(@"增加表字段失败:%s", error);
        return NO;
    }
    NSLog(@"增加表字段成功");
    return YES;

}


- (BOOL)addColumnToSheet:(NSString *)sheetName withAttributeArray:(NSArray *)attributeArray {  // 待优化

    if (!sheetName) {
        NSLog(@"error:名字为nil");
        return NO;
    }
    
    if (!attributeArray.count) {
        NSLog(@"字段数据为空");
        return NO;
    }
    
    BOOL result = YES;
    for (NSString *attribute in attributeArray) {
        
        BOOL result2 = [self addColumnToSheet:sheetName withAttribute:attribute];
        if (!result2) { // 失败了
            result = NO;
        }
    }
    return result;
}


- (void)changeColumnToSheet:(NSString *)sheetName newAttribute:(NSString *)newAttribute oldAttribute:(NSString *)oldAttribute{
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}



- (void)searchWithSheets:(NSArray *)sheetS where:(NSString *)condition{
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
#pragma - mark 数据增删改查


- (BOOL)insertDataToSheet:(NSString *)sheetName withData:(NSArray *)data {

    //预判断
    NSInteger count = [self getSheetAttributesCountWithSheet:sheetName];
    if (data.count != count) {
        NSLog(@"error:数据个数不匹配");
        return NO;
    }
    
    //构造sql语句,其中插入的数据用占位符？代替
    NSString *placeHoderString = [[NSString alloc]init];
    for (int i = 0 ; i < data.count; i ++) {
        if (i == data.count - 1) {
            placeHoderString = [placeHoderString stringByAppendingString:[NSString stringWithFormat:@" \"%@\" ",data[i]]];
            break;
        }
        placeHoderString = [placeHoderString stringByAppendingString:[NSString stringWithFormat:@" \"%@\",",data[i]]];
    }
    NSString *targetString  = [NSString stringWithFormat:@"INSERT INTO \"%@\" VALUES(%@)",sheetName,placeHoderString];
    NSLog(@"%@",targetString);

    
    //执行SQL语句
    char *error = NULL;
    int result = sqlite3_exec(_sqlite, [targetString UTF8String], NULL, NULL, &error);
    if (result != SQLITE_OK) {
        NSLog(@"error:%s",error);
        return NO;
    }
    
    
    NSLog(@"数据插入成功");
    return YES;


}

- (NSArray *)searchDataFromSheet:(NSString *)sheetName where:(NSString *)condition{
    
    if (!sheetName || !condition) {
        NSLog(@"error:输入错误");
        return nil;
    }
    
    NSMutableArray *dataArray = [NSMutableArray array];
    NSInteger count = [self getSheetAttributesWithSheet:sheetName].count;
    NSLog(@"这个表有%ld个字段",(long)count);
    
    
    //构造sql语句
    NSString *targetsql = [NSString stringWithFormat:@"SELECT * FROM \"%@\" Where %@",sheetName,condition] ;
    NSLog(@"查找语句＝%@",targetsql);
    
    //预编译
    sqlite3_stmt *ppStmt = NULL;
    int result = sqlite3_prepare_v2(_sqlite, [targetsql UTF8String], -1, &ppStmt, NULL);
    if (result != SQLITE_OK) {
        NSLog(@"预编译失败");
        return nil;
    }
    
    
    //执行Sql语句
    int hasData = sqlite3_step(ppStmt);
    NSLog(@"%d",hasData);
    //代表当前有一行数据
    while (hasData == SQLITE_ROW) {
        
        //读出当前行数据的每一个字段内容
        const  unsigned char *str;
        NSMutableArray *dataModel = [NSMutableArray array];
        for (int i = 0 ; i < count; i++) {
            
            str = sqlite3_column_text(ppStmt, i); //读出当前行的每一列内容
            if (str == NULL) {
                [dataModel addObject:@""];
            }
            else{
                [dataModel addObject:[NSString stringWithUTF8String:(const char*)str]];
            }
            
            
        }
        //把Model加入到数组中
        [dataArray addObject:dataModel];
        //让游标指向下一行
        hasData = sqlite3_step(ppStmt);
        
    }
    NSLog(@"当前表符合条件的数据  = %@",dataArray);
    sqlite3_finalize(ppStmt);
    return dataArray;
    
    
}



- (BOOL)deleateDataFromSheet:(NSString *)sheetName where:(NSString *)condition{

    if (!sheetName || !condition) {
        NSLog(@"error:输入信息错误");
        return NO;
    }

    NSString *targetSql = [NSString stringWithFormat:@"DELETE FROM \"%@\" WHERE %@",sheetName,condition];
    NSLog(@"删除语句:%@",targetSql);
    
    //执行SQL语句
    char *error = NULL;
    int result = sqlite3_exec(_sqlite, [targetSql UTF8String], NULL, NULL, &error);
    if (result != SQLITE_OK) {
        NSLog(@"error:%s",error);
        return NO;
    }
    
    
    NSLog(@"数据删除成功");
    return YES;

    
}


- (BOOL)updateDataToSheet:(NSString *)sheetName withData:(NSArray *)data where:(NSString *)condition{
    
    //判断
    LCCSqliteManager *_manager  = [LCCSqliteManager shareInstance];
    NSArray *attributes = [_manager getSheetAttributesWithSheet:sheetName];
    if (data.count != attributes.count) {
        NSLog(@"数据个数不匹配");
        return NO;
    }
    
    if(!data || !condition){
        NSLog(@"error:输入错误");
        return NO;
    }
    
    
    //需要更新的字段构造，这里默认更新整条数据（有待改进）。
    NSString *updataDataString = [[NSString alloc]init];
    for (int i = 0 ; i < attributes.count; i ++) {
        if (i == attributes.count - 1) {
            NSString *pstr = [NSString stringWithFormat:@" \"%@\"= \'%@\' ",attributes[i], data[i]];
            updataDataString = [updataDataString stringByAppendingString:pstr];
            break;
        }
        NSString *pstr = [NSString stringWithFormat:@" \"%@\"= \'%@\' ,",attributes[i], data[i]];
        updataDataString = [updataDataString stringByAppendingString:pstr];

    }

    
    //Sql构造
    NSString *targetSql = [NSString stringWithFormat:@"UPDATE \"%@\" SET %@ WHERE %@",sheetName,updataDataString,condition];
    
    NSLog(@"更新语句:%@",targetSql);
    
    
    
    //执行SQL语句。
    char *error = NULL;
    int result = sqlite3_exec(_sqlite, [targetSql UTF8String], NULL, NULL, &error);
    if (result != SQLITE_OK) {
        NSLog(@"error:%s",error);
        return NO;
    }
    
    NSLog(@"数据更新成功");
    return YES;
}

#pragma mark - ForeignKey

//目前暂
- (BOOL)openForeignkey{
    
    //构造sql语句
    NSString *targetSql = [NSString stringWithFormat:@"PRAGMA foreign_keys = ON"];
    //执行sql语句
    char *error = NULL;
    int result = sqlite3_exec(_sqlite, [targetSql UTF8String], NULL, NULL, &error);
    if (result != SQLITE_OK) {
        NSLog(@"外建支持打开失败:%s", error);
        return NO;
    }
    NSLog(@"外建支持打开成功");
    return YES;

}

- (BOOL)closeForeignkey{
    
    //构造sql语句
    NSString *targetSql = [NSString stringWithFormat:@"PRAGMA foreign_keys = OFF"];
    //执行sql语句
    char *error = NULL;
    int result = sqlite3_exec(_sqlite, [targetSql UTF8String], NULL, NULL, &error);
    if (result != SQLITE_OK) {
        NSLog(@"外建支持关闭失败:%s", error);
        return NO;
    }
    NSLog(@"外建支持关闭成功");
    return YES;
    
}


#pragma mark - Auxiliary function
- (NSString *)conditionExchange:(NSString *)oldcondition{
    
    NSString *newCondition = [oldcondition stringByReplacingOccurrencesOfString:@"”" withString:@"\""];
    newCondition = [newCondition stringByReplacingOccurrencesOfString:@"”" withString:@"\""];
    
    return newCondition;
}

@end
