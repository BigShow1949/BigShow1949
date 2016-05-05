//
//  MenuData.m
//  MutableMenuTableView
//
//  Created by 张国庆 on 16/4/27.
//  Copyright © 2016年 zgq. All rights reserved.
//

#import "MenuData.h"

@implementation MenuData
@synthesize treeItemsToInsert;
@synthesize treeItemsToRemove;
-(id)init
{
    self=[super init];
    if(self)
    {
        self.tableViewData = [NSMutableArray array];
        self.treeItemsToInsert=[NSMutableArray array];
        self.treeItemsToRemove=[NSMutableArray array];
        [self getData];
    }
    return self;
}
-(void)getData
{
    //做一组服务器很有可能给的数据模型
    NSMutableArray *arr0=[NSMutableArray array];
    NSMutableArray *arr1=[NSMutableArray array];
    NSMutableArray *arr2=[NSMutableArray array];
    for(int i=0 ; i<10 ; i++)
    {
        MyItem *item=[[MyItem alloc] init];
        item.classId_=@"0";
        item.id_=[NSString stringWithFormat:@"%d",i];
        item.title=[NSString stringWithFormat:@"title_%d",i];
        [arr0 addObject:item];
        for(int j=0;j<3;j++)
        {
            MyItem *item=[[MyItem alloc] init];
            item.classId_=[NSString stringWithFormat:@"%d",i];
            item.id_=[NSString stringWithFormat:@"%d",10+i*3+j+1];
            item.title=[NSString stringWithFormat:@"title_%d",10+i*3+j+1];
            [arr1 addObject:item];
            for(int m=0;m<2;m++)
            {
                MyItem *item=[[MyItem alloc] init];
                item.classId_=[NSString stringWithFormat:@"%d",10+i*3+j+1];
                item.id_=[NSString stringWithFormat:@"%d",40+i*3*2+j*2+m+1];
                item.title=[NSString stringWithFormat:@"title_%d",40+i*3*2+j*2+m+1];
                [arr2 addObject:item];
            }
        }
    }
    
    for (MyItem *item in arr2) {  // 三级目录
        NSLog(@"item.title = %@", item.title);
    }
    //做成自己想要的数据结构
    
    for(int i=0 ;i<[arr0 count];i++)
    {
        MyItem *item0=[arr0 objectAtIndex:i];
        item0.level=0;
        item0.subItems=[NSMutableArray array];
        for(int j=0;j<[arr1 count];j++)
        {
            MyItem *item1=[arr1 objectAtIndex:j];
            if([item1.classId_ isEqualToString:item0.id_])
            {
                item1.level=1;
                item1.subItems=[NSMutableArray array];
                
                for(int m=0;m<[arr2 count];m++)
                {
                    MyItem *item2=[arr2 objectAtIndex:m];
                    if([item2.classId_ isEqualToString:item1.id_])
                    {
                        item2.level=2;
                        item2.subItems =[NSMutableArray array];
                        [item1.subItems addObject:item2];
                    }
                }
                [item0.subItems addObject:item1];
            }
        }
        [_tableViewData addObject:item0];
        
    }
}
- (NSMutableArray *) insertCellPaths:(NSIndexPath *)indexPath
{
    
    
    NSMutableArray * insertCellPaths;
    insertCellPaths = [NSMutableArray array];
    MyItem * item;
    item = [_tableViewData objectAtIndex:indexPath.row];
    
    for (int i = 0; i< [item.subItems count]; i++) {
        MyItem *insertItem;
        insertItem = [item.subItems objectAtIndex:i];
        [_tableViewData insertObject:insertItem atIndex:indexPath.row+i+1 ];
        [insertCellPaths addObject:[NSIndexPath indexPathForRow:indexPath.row+i+1 inSection:0]];
    }
    item.isSubItemOpen = YES;
    
    return insertCellPaths;
    
}

- (NSMutableArray *) cascadingInsertCellPaths:(NSIndexPath *)indexPath
{
    [treeItemsToInsert removeAllObjects];
    
    MyItem * item;
    item = [_tableViewData objectAtIndex:indexPath.row];
    
    for (int i = 0; i < [item.subItems count]; i++) {
        MyItem * insertItem;
        insertItem = [item.subItems objectAtIndex:i];
        NSLog(@"insert %@",insertItem);
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:[_tableViewData indexOfObject:item] inSection:0];
        [_tableViewData insertObject:insertItem atIndex:path.row +1+i];
        
        [self cascadingInsertPaths:insertItem];
        
        [treeItemsToInsert addObject:[NSIndexPath indexPathForRow:path.row+i+1 inSection:0]];
    }
    
    // [self cascadingInsertPaths:item];
    
    item.isSubItemOpen = YES;
    return treeItemsToInsert;
}

- (void) cascadingInsertPaths:(MyItem *)item
{
    for (int i = 0; i < [item.subItems count] && item.isCascadeOpen ; i++) {
        MyItem * item1;
        item1 = [item.subItems objectAtIndex:i];
        NSLog(@"insert %@",item1);
        
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:[_tableViewData indexOfObject:item] inSection:0];
        
        [_tableViewData insertObject:item1 atIndex:path.row +1+i];
        
        [self cascadingInsertPaths:item1];
        [treeItemsToInsert addObject:[NSIndexPath indexPathForRow:path.row+i+1 inSection:0]];
        
        item.isSubItemOpen = YES;
    }
    
}
- (NSMutableArray *) cascadingDeletePaths:(NSIndexPath *)indexPath
{
    [treeItemsToRemove removeAllObjects];
    MyItem * item;
    item = [_tableViewData objectAtIndex:indexPath.row];
    
    [self cascadingDeleteCellPaths:item];
    
    NSMutableIndexSet * set;
    set = [NSMutableIndexSet indexSet];
    for (int i = 0; i < [treeItemsToRemove count]; i++) {
        NSIndexPath *index;
        index  = [treeItemsToRemove objectAtIndex:i];
        [set addIndex:index.row];
    }
    item.isSubItemOpen = NO;
    [_tableViewData removeObjectsAtIndexes:set];
    return treeItemsToRemove;
}
- (void) cascadingDeleteCellPaths:(MyItem *)item
{
    
    for (int i = 0; i < [item.subItems count] && item.isSubItemOpen ; i++) {
        MyItem * item1;
        item1 = [item.subItems objectAtIndex:i];
        NSLog(@"sub %@",item1);
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:[_tableViewData indexOfObject:item1] inSection:0];
        
        [self cascadingDeleteCellPaths:item1];
        [treeItemsToRemove addObject:path];
        item1.isSubItemOpen = NO;
    }
}
- (NSMutableArray *) deleteCellPaths: (NSIndexPath *)indexPath
{
    NSMutableArray * deleteCellPaths;
    deleteCellPaths = [NSMutableArray array];
    MyItem * item;
    item = [_tableViewData objectAtIndex:indexPath.row];
    
    for (int i = 0; i< [item.subItems count]; i++) {
        MyItem *deleteItem;
        deleteItem = [item.subItems objectAtIndex:i];
        
        
        
        [deleteCellPaths addObject:[NSIndexPath indexPathForRow:indexPath.row+i+1 inSection:0]];
    }
    
    
    [_tableViewData removeObjectsInRange: NSMakeRange(indexPath.row+1, [item.subItems count])];
    
    item.isSubItemOpen = NO;
    
    return deleteCellPaths;
}




- (NSMutableArray *) insertCellPaths:(MyItem *)item rowAtIndexPath :(NSIndexPath *)indexPath
{
    
    NSMutableArray * insertCellPaths;
    insertCellPaths = [NSMutableArray array];
    
    for (int i = 0; i< [item.subItems count]; i++) {
        MyItem *insertItem;
        insertItem = [item.subItems objectAtIndex:i];
        [_tableViewData insertObject:insertItem atIndex:indexPath.row+i+1 ];
        [insertCellPaths addObject:[NSIndexPath indexPathForRow:indexPath.row+i+1 inSection:0]];
    }
    
    
    return insertCellPaths;
}

@end
