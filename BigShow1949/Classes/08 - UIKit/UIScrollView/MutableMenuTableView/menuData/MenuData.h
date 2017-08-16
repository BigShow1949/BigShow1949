//
//  MenuData.h
//  MutableMenuTableView
//
//  Created by 张国庆 on 16/4/27.
//  Copyright © 2016年 zgq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#import "MyItem.h"

@interface MenuData : NSObject
{
    NSMutableArray * treeItemsToRemove;
    NSMutableArray * treeItemsToInsert;
}
@property (nonatomic,strong) NSMutableArray *tableViewData;
@property (nonatomic,strong) NSMutableArray *treeItemsToRemove;
@property (nonatomic,strong) NSMutableArray *treeItemsToInsert;
- (NSMutableArray *) cascadingDeletePaths:(NSIndexPath *)indexPath;
- (NSMutableArray *) cascadingInsertCellPaths:(NSIndexPath *)indexPath;
- (NSMutableArray *) deleteCellPaths: (NSIndexPath *)indexPath;

@end
