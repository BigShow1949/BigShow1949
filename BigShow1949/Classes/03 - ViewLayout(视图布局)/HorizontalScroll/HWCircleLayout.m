//
//  HWCircleLayout.m
//  自定义CollectionView布局
//
//  Created by apple on 14/12/27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWCircleLayout.h"

@implementation HWCircleLayout

/**
 * 设置UICollectionView内部所有元素的布局参数(cell\SupplementaryView\DecorationView)
 *
 *  @return 数组中存放的都是UICollectionViewLayoutAttributes对象, 一个cell对应一个UICollectionViewLayoutAttributes对象
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray array];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i < count; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:path];
        [array addObject:attrs];
    }
    return array;
}

// CollectionView和tableView

// tableView : cell\header\footer\section footer\section header
// CollectionView : cell\SupplementaryView\DecorationView

/**
 *  计算indexPath这个位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemWH = 40;
    CGFloat collectionViewW = self.collectionView.bounds.size.width;
    CGFloat collectionViewH = self.collectionView.bounds.size.height;
    
    // 圆心
    CGPoint circleCenter = CGPointMake(collectionViewW * 0.5, collectionViewH * 0.5);
    // 半径
    CGFloat circleRadius = (MIN(collectionViewH, collectionViewW) - itemWH) * 0.5;
    
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // cell的尺寸
    attrs.size = CGSizeMake(itemWH, itemWH);
    
    // cell的位置
    if (count == 1) {
        attrs.center = circleCenter;
    } else {
        CGFloat angleUnit = M_PI * 2 / count; // 单位角度
        CGFloat angle = indexPath.item * angleUnit; // 每个item的角度
        CGFloat attrsCenterX = circleCenter.x + circleRadius * cos(angle);
        CGFloat attrsCenterY = circleCenter.y + circleRadius * sin(angle);
        attrs.center = CGPointMake(attrsCenterX, attrsCenterY);
        
        // zIndex大的cell显示在上面
//        attrs.zIndex = count - indexPath.item;
    }
    
    return attrs;
}
@end
