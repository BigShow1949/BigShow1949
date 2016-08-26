//
//  FMDBBaseUseViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/4/15.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "FMDBBaseUseViewController.h"
#import "FMDB.h"

@interface FMDBBaseUseViewController ()
@property (nonatomic, strong) FMDatabase *db;

@end

@implementation FMDBBaseUseViewController


-(void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"student.sqlite"];
    
    NSLog(@"fileName = %@", fileName);
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    
     //3.打开数据库
    if ([db open]) {
        // 4.创建表
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
        if (result) {
            NSLog(@"创表成功");
        }else
        {
            NSLog(@"创表失败");
        }
    }
    
    self.db = db;

}



// 生成表
- (void)crate {
    [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
    
}



- (IBAction)insert:(id)sender {
    
    for (int i = 0; i<10; i++) {
        NSString *name = [NSString stringWithFormat:@"jack-%d", arc4random_uniform(100)];
        // executeUpdate : 不确定的参数用?来占位
        BOOL result = [self.db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);", name, @(arc4random_uniform(40))];
        
        if (result) {
            NSLog(@"成功插入数据");
        }else {
         
            NSLog(@"error");
        }
        //        [self.db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);" withArgumentsInArray:@[name, @(arc4random_uniform(40))]];
        
        // executeUpdateWithFormat : 不确定的参数用%@、%d等来占位
        //        [self.db executeUpdateWithFormat:@"INSERT INTO t_student (name, age) VALUES (%@, %d);", name, arc4random_uniform(40)];
    }
}

- (IBAction)delete_:(id)sender {
    //    [self.db executeUpdate:@"DELETE FROM t_student;"];
    [self.db executeUpdate:@"DROP TABLE IF EXISTS t_student;"];

}

- (IBAction)update:(id)sender {
    
    // 全部更新 注意:将t_student表中所有记录的name都改为jack-101，age都改为40
    [self.db executeUpdate:@"UPDATE t_student SET name = 'jack-101', age = 40 WHERE id = 4"];
    
//    // 局部更新
//    [self.db executeUpdate:@"UPDATE t_student SET AGE"];
    
}

- (IBAction)select:(id)sender {
    // 1.执行查询语句
    FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM t_student"];
    
    // 2.遍历结果
    while ([resultSet next]) {
        int ID = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet stringForColumn:@"name"];
        int age = [resultSet intForColumn:@"age"];
        NSLog(@"%d %@ %d", ID, name, age);
    }

}


@end
