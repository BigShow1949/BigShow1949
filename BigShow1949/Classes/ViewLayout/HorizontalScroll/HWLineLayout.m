//
//  HWLineLayout.m
//  自定义CollectionView布局
//
//  Created by apple on 14/12/25.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWLineLayout.h"

@implementation HWLineLayout

- (instancetype)init
{
    if (self = [super init]) {
        self.itemSize = CGSizeMake(100, 100);
        self.minimumLineSpacing = 50;  // 这个定义了每个item在水平方向上的最小间距。
        self.minimumInteritemSpacing = 50;  // 两个同一列的相邻的cell之间的最小间距。
        // 水平滚动
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

/*
 当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 * 只要布局刷新了,首先会调用这个方法
 */
- (void)prepareLayout
{
//    NSLog(@"collectionView.bounds = %@", NSStringFromCGRect(self.collectionView.bounds));
//    NSLog(@"itemSize = %@", NSStringFromCGSize(self.itemSize));
    CGFloat inset = (self.collectionView.bounds.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    // 用self.sectionInset替代self.collectionView.contentInsets设置间距
    // self.sectionInset会保留collectionView之前的contentInsets
}

/**
 *  控制collectionView停止滚动时所停留的最终位置
 *
 *  @param proposedContentOffset 默认情况下,collectionView停止滚动时的contentOffset值
 *  @param velocity              速度
 *
 *  @return collectionView停止滚动时的最终contentOffset值
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 计算屏幕最中间的x值
    CGFloat screenCenterX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    // 计算屏幕的可见范围
    CGRect visiableRect;
    visiableRect.origin = proposedContentOffset;
    visiableRect.size = self.collectionView.bounds.size;
    
    // 获得可见范围内的cell的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:visiableRect];
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) { // 遍历所有cell的布局属性

        NSLog(@"attrs.center.x = %f, screenCenterX = %f, attrs.center.x - screenCenterX = %f", attrs.center.x, screenCenterX, attrs.center.x - screenCenterX);
        if (ABS(attrs.center.x - screenCenterX) < ABS(minDelta)) {
            minDelta = attrs.center.x - screenCenterX;
            NSLog(@"minDelta  =%f", minDelta);
        }else {
            NSLog(@"应该不会运行到这里");
        }
    }
    
    return CGPointMake(proposedContentOffset.x + minDelta, proposedContentOffset.y);
}

/*
 UICollectionViewLayoutAttributes的作用: 设置cell的尺寸\透明度\形变属性
 */

/**
 * 设置UICollectionView内部所有元素的布局参数
 *
 *  @return 数组中存放的都是UICollectionViewLayoutAttributes对象, 一个cell对应一个UICollectionViewLayoutAttributes对象
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    

    // 计算屏幕最中间的x值
    CGFloat screenCenterX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;


    // 可见范围
//    CGRect visiableRect;
//    visiableRect.size = self.collectionView.bounds.size;
//    visiableRect.origin = self.collectionView.contentOffset;
    
    for (UICollectionViewLayoutAttributes *attrs in array) {
        CGFloat scale = 1.0 + 0.5 * (1.0 - (ABS(screenCenterX - attrs.center.x) / 200));
        NSLog(@"screenCenterX = %f, attrs.center.x = %f, abs= %f, scale = %f", screenCenterX, attrs.center.x, screenCenterX - attrs.center.x, scale);
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
//        attrs.transform3D = CATransform3DMakeScale(scale, scale, 1.0);
//        CGFloat distance = ABS(screenCenterX - attrs.center.x);
//        attrs.transform3D = CATransform3DMakeRotation(M_PI_2 * (distance / 200), 0, 1, 0);
    }
    
    NSLog(@"######################");
    return array;
}

@end
