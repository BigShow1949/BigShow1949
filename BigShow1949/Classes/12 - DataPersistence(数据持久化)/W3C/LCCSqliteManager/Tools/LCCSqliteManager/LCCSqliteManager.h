//
//  LCCSqliteManager.h
//  LCCSqliteManagerDemo
//
//  Created by LccLcc on 15/11/25.
//  Copyright © 2015年 LccLcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCCSqliteSheetHandler.h"
#import <sqlite3.h>



@interface LCCSqliteManager : NSObject



/**
 * # manager的单例方法
 */
+ (LCCSqliteManager*)shareInstance;


#pragma mark - Sqlite信息查询
/**
 * # 数据库信息
 */
+ (NSString*)sqliteLibVersion;


/**
 * # 是否线程安全
 */
+ (BOOL)isSqliteThreadSafe;




#pragma mark - manager进行数据库文件的操作
/**
 * # 打开一个存在的数据库文件,或者创建一个不存在的数据库文件
 
 * @ ios的数据库文件默认存在沙盒路径下,你只需要传入文件名。
  */
- (BOOL)openSqliteFile:(NSString *)filename;



/**
 * # 关闭当前打开的数据库文件
 
 * @ 注意:一旦打开一个数据库文件，你就有义务管理那些非OC对象所占用的内存，尽量避免内存泄漏和野指针。下面这个方法会对那些非OC对象指针进行销毁。
 */
- (BOOL)closeSqliteFile;



/**
 * # 删除指定的数据库文件
 
 * @ 该操作可以指定删除文件，需要传入文件名作为参数。删除的时候会先关闭当前数据库文件。
 */
- (BOOL)deleateSqliteFile:(NSString *)filename;







#pragma mark - manager进行表操作
/**
 * # 获取当前数据库文件的所有表名
 */
- (NSArray*)getAllSheetNames;



/**
 * # 创建一张表
 
 * @ 你必需要传入的参数是表名以及字段pAttributes,pAttributes是一个数组,存放的是这张表的字段
 * @ 例如，创建一张名为学生成绩的表，那么pName = @“学生成绩”,pAttributes = @[@"姓名",@“学号”,@"成绩"];
 * @ 表名和字段可以为@“”，但不可以为nil。不过希望表名和字段尽量不为@“”,既不符合实际，也可能会有歧义出现
 * @ 参数primaryKey的作用是，标记一个字段作为主键，被标记的字段在整张表中不会出现一样的数据，你可以用主键作为数据的唯一
 标识。如果你希望这张表中的某个字段可以与其他表建立起联系，那么设置这个字段为主键。
 
 * @ 1.1版本中已删除该方法
 */
//- (BOOL)createSheetWithName:(NSString *)pName attributes:(NSArray *)pAttributes primaryKey:(NSString *)pkey;



/**
 * # 创建一张带约束的表
 
 * @ 通过这个方法，你可以建立一张依赖于有唯一标识(主键)的表，你需要传入以下参数:
 * @ 新表的名字、字段与主键,旧表的名字与主键,以及两表间的依赖关系。
 * @ 你需要注意的是，有主键的表才能够作为主表，否则主键与外键失去意义
 
 * @1.1版本中已删除该方法
 
 */
//- (BOOL)createSheetWithName:(NSString *)pName attributes:(NSArray *)pAttributes primaryKey:(NSString *)pKey   referenceSheet:(NSString*)oldName referenceType:(LCCSheetReferencesType)type;




/**
 * # 创建一张表
 
 * @ 1.1版本中希望通过这种方式建表，你可以不用一次性传入那么多参数，你只要在block中对sheet进行相关设置即可，创建具体方式参考LCCSqliteSheetHandler的相关设定。
 */
- (BOOL)createSheetWithSheetHandler:(void (^)(LCCSqliteSheetHandler *sheet)) sheetHandler;



/**
 * # 删除一张表
 
 * @你需要传入表名
 */
- (BOOL)deleateSheetWithName:(NSString *)pName;



/**
 * # 获取表的字段
 
 * @你需要传入表名,返回一个存放字段的数组
 */
- (NSArray *)getSheetAttributesWithSheet:(NSString *)pName;



/**
 * # 获取表的字段数
 
 * @ 你需要传入表名,返回一个NSInteger
 */
- (NSInteger )getSheetAttributesCountWithSheet:(NSString *)pName;


/**
 * # 获取表的主键
 
 * @ 你需要传入表名,返回一个NSArray
 
 * @ 虽然主键只有一个，但是主键可以由多个字段组合而成，因此返回的是一个数组，里面存放了组合成主键的相关字段
 */
- (NSArray *)getSheetPrimaryKeyWithSheet:(NSString *)pName;




/**
 * # 获取表的所有数据
 
 * @ 你需要传入表名,返回一个数组,存放了所有数据,数组中每一个对象代表一行数据
 */
- (NSArray *)getSheetDataWithSheet:(NSString *)pName;



/**
 * # 获取表的数据个数
 
 * @ 你需要传入表名,返回一个NSInteger
 */
- (NSInteger )getSheetDataCountWithSheet:(NSString *)pName;




/**
 * # 表拷贝
 
 * @
 */
- (void)copySheetWithSheet:(NSString *)sheetName;



/**
 * # 增加表的字段
 
 * @attribute 增加的字段
 */
- (BOOL)addColumnToSheet:(NSString *)sheetName withAttribute:(NSString *)attribute;


/**
 * # 增加表的字段
 
 * @attributeArray 传入一个数组,每个元素就是需要增加字段的名字
 */
- (BOOL)addColumnToSheet:(NSString *)sheetName withAttributeArray:(NSArray *)attributeArray;


/**
 * # 修改表的字段
 
 * @
 */
- (void)changeColumnToSheet:(NSString *)sheetName newAttribute:(NSString *)newAttribute oldAttribute:(NSString *)oldAttribute;



/**
 * # 建立索引
 
 * @
 */
- (void)createIndexToSheet:(NSString *)sheetName withIndex:(NSArray *)index;


/**
 * # 多表联查
 
 * @
 */
- (void)searchWithSheets:(NSArray *)sheetS where:(NSString *)condition;



#pragma mark -manager进行数据的增删改查
/**
 * # 向表添加一行数据,插在末尾
 
 * @ 你需要传入两个参数,表名以及你要插入的数据,例如,你要向名为学生成绩的表内插入一条数据,则可以执行代码
 [_manager insertDataToSheet:@"学生成绩" withData @[@“LCC”,@“16”,@"100"]],注意,你需要保证数组的count和表
 字段数一致,否则返回No。
 */
- (BOOL)insertDataToSheet:(NSString *)sheetName withData:(NSArray *)data;


/**
 * # 查找指定数据
 
 * @ 你需要传入两个参数，表名以及查找条件,例如,你要查看“学生成绩”这张表中条件为“姓名”=‘LCC’的信息，你可以执行如下代码:
 [_manager searchDataFromSheet:@“学生成绩” Where:@" \“姓名\"=\'LCC\' " ，注意，condition参数中，你需要对字段和值进行区分，字段名需要用双引号，数值需要用单引号，且区分大小写(这对于我这个不区分大小写的人来说真困按钮) 。因此字符串中需要用\对双引号和单引号做出标示。条件为姓名='LCC'，查找并不会失败，但是当出现字段是数字等其他情况时，会产生歧义，即类似条件为1='',数据库无法识别这里的1是什么，也就无法进行正确的查询。换言之，数据库中，字符串用单引号标示，字段，表名等用双引号标示。为了确保查找无误，希望代码中都做出区分。总结而言，"属性" 运算符 ‘值’  的查找方式能够确保查找的准确性
 
 * @ 为了统一数据类型，数据库中所有的数据类型我都选择了TEXT字符串进行保存，所有的数据类型转换都希望放在你的代码中进行转换，因此这里不提供任何数据的相关计算方法，仅做数据存储用。
 
 
 * @下面列出常用的查询条件:
 * @精确查找条件:NSString *priciseContion = [NSString stringWithFormat:@" \"姓名\"=\'LCC\' "];
 * @模糊查找条件:NSString *fuzzyContion = [NSString stringWithFormat:@" \"姓名\"Like\'张%\' "];
 * @比较查找条件:NSString *compareContion = [NSString stringWithFormat:@" \"成绩\">\'100\' "];
 * @....others
 
 
 * @上述查找条件可以组合输入，条件之间用and连接，比如你需要查找成绩>80分的且姓李的人，则代码如下:
 
 NSString * searchCondition = @"   \"姓名\" Like \'李%\' and  \"成绩\" > \'80\'  ";
 [_manager searchDataFromSheet:@"学生成绩"  where:searchCondition ]；
    查找成功的话会返回一个按查找条件进行排序的数组
 
 * @ 补充一点，因为存储类型都是TEXT，因此，比较字符串'20' 与'3'，结果是后者大，你可以进行数据转换成NSInteger后再比较，若一定要在数据库中进行运算，你要确保数据存储的位数一致，既比较'20' 与'03'，这样得出的结果方才符合你的要求。
 */
- (NSArray *)searchDataFromSheet:(NSString *)sheetName where:(NSString *)condition;



/**
 * # 删除指定数据
 
 * @ 你需要传入两个参数，表名以及查找条件,查找条件同上。
 * @ 例如，你希望删除表名为学生成绩中“姓名”=‘LCC’的相关数据，则执行代码[_manager deleateDataWhiere:@" \"姓名"= \'LCC\' " from:@"学生成绩"];
 * @ 注意：在使用此方法时，要避免出现tableView和数据库数据不匹配的情况，比如，你用tableView自带的删除动画删除了一行cell，并对应的删除了数据库中的数据，tableView刷新以后得到了新的数据，倘若你没有确保数据库里也只删除了一条数据，那么就会抛出异常。
 * @ 避免上述异常出现的情况，取决于你所创建表是否有唯一标示，rowid不适合作为这个标示，因为tableViewCell的indexPath是自动更新的，rowid确是唯一不变的。即你在删除cell时，输入的删除条件要确保数据库中只会删除同一条数据。
 */
- (BOOL)deleateDataFromSheet:(NSString *)sheetName where:(NSString *)condition;


/**
 * # 更新指定数据
 
 * @ 你需要传入三个参数，表名、查找条件以及你希望更新的数据。查找条件格式同上。
 * @ 例如，你要更新表名为学生成绩中“姓名”=‘LCC’的相关数据，则执行代码[_manager updateDataToSheet:@"学生成绩" withData:@[@"Lcc",@"16",@"100"] Where:@" \"姓名"= \'LCC\' "];
 * @ 注意，你输入的数据必须和表的字段数一致，否则无法更新数据
 */
- (BOOL)updateDataToSheet:(NSString *)sheetName withData:(NSArray *)data where:(NSString *)condition;



#pragma mark - ForeignKey
/**
 * # 关闭外键支持
 
 * @ 当你希望向存在外键依赖的表中进行数据的”强制“操作，你可以执行此方法关闭外键支持。一般情况下你不会用到此方法。
 */
- (BOOL)closeForeignkey;


@end
