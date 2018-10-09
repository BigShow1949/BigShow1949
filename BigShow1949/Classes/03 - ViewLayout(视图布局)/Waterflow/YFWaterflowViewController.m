//
//  YFWaterflowViewController.m
//  BigShow1949
//
//  Created by 杨帆 on 15-9-2.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//
#import "YFWaterflowViewController.h"
#import "YFShop.h"
#import "YFShopCell.h"
#import "YFWaterflowLayout.h"
#import "MJExtension.h"
#import "MJRefresh.h"

@interface YFWaterflowViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, YFWaterflowLayoutDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *shops;
@end

@implementation YFWaterflowViewController

- (NSMutableArray *)shops
{
    if (!_shops) {
        self.shops = [[NSMutableArray alloc] init];
    }
    return _shops;
}

static NSString * const CellId = @"shop";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"流水布局展示";
    
    // 初始化数据
    [self.shops addObjectsFromArray:[YFShop objectArrayWithFilename:@"1.plist"]];
    
    // 创建布局
    YFWaterflowLayout *layout = [[YFWaterflowLayout alloc] init];
    layout.delegate = self;
    
    // 创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerNib:[UINib nibWithNibName:@"YFShopCell" bundle:nil] forCellWithReuseIdentifier:CellId];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 添加刷新控件
    //    [self.collectionView addHeaderWithCallback:^{
    //        NSLog(@"进入下拉刷新状态");
    //    }];
    //    [self.collectionView addFooterWithCallback:^{
    //        NSLog(@"进入shang拉刷新状态");
    //    }];
    
    self.collectionView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    self.collectionView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
}

- (void)loadNewShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *newShops = [YFShop objectArrayWithFilename:@"2.plist"];
        [self.shops insertObjects:newShops atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newShops.count)]];
        [self.collectionView reloadData];
        
        // stop refresh
//        [self.collectionView headerEndRefreshing];
        [self.collectionView.mj_header endRefreshing];
    });
}

- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *newShops = [YFShop objectArrayWithFilename:@"3.plist"];
        [self.shops addObjectsFromArray:newShops];
        [self.collectionView reloadData];
        
        // stop refresh
        [self.collectionView.mj_footer endRefreshing];
    });
}

#pragma mark - <YFWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(YFWaterflowLayout *)waterflowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth
{
    YFShop *shop = self.shops[indexPath.item];
    return shop.h * itemWidth / shop.w;
}

//- (UIEdgeInsets)insetsInWaterflowLayout:(YFWaterflowLayout *)waterflowLayout
//{
//    return UIEdgeInsetsMake(30, 30, 30, 30);
//}

//- (int)maxColumnsInWaterflowLayout:(YFWaterflowLayout *)waterflowLayout
//{
//    return 2;
//}

//- (CGFloat)rowMarginInWaterflowLayout:(YFWaterflowLayout *)waterflowLayout
//{
//    return 30;
//}
//
//- (CGFloat)columnMarginInWaterflowLayout:(YFWaterflowLayout *)waterflowLayout
//{
//    return 50;
//}

#pragma mark - <UICollectionViewDataSource>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YFShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellId forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
