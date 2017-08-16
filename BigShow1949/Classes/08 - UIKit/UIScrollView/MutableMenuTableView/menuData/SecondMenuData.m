//
//  SecondMenuData.m
//  MutableMenuTableView
//
//  Created by 张国庆 on 16/4/28.
//  Copyright © 2016年 zgq. All rights reserved.
//

#import "SecondMenuData.h"

@implementation SecondMenuData

-(id)init
{
    self=[super init];
    if(self)
    {
        self.tableViewData=[NSMutableArray array];
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
            
        }
    }
    NSLog(@"%@",arr2);
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
                
                [item0.subItems addObject:item1];
            }
        }
        [_tableViewData addObject:item0];
        
    }
}
@end
