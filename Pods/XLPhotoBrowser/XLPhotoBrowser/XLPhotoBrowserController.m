//
//  XLPhotoBrowserController.m
//  XLPhotoBrowser <https://github.com/xiaoL0204/XLPhotoBrowser>
//  
//
//  Created by xiaoL on 16/11/29.
//  Copyright © 2016年 xiaolin. All rights reserved.
//

#import "XLPhotoBrowserController.h"
#import "XLPhotoCollectionCell.h"


@interface XLPhotoBrowserController () <UICollectionViewDelegate,UICollectionViewDataSource,XLPhotoBrowserTapDelegate>
@property (nonatomic, strong) NSArray<id<XLPhotoBrowserAdapterDelegate>> *imageAdaptersBank;
@property (nonatomic, strong) id<XLPhotoBrowserAdapterDelegate> currentImgAdapter;
@property (nonatomic, strong) UICollectionView *collectionView; // 显示图片的collectionView
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end

@implementation XLPhotoBrowserController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    NSInteger index = [self.imageAdaptersBank indexOfObject:self.currentImgAdapter];
    [self setupTitleIndexWithCurrent:index+1];
    if (index>=0 && index<self.imageAdaptersBank.count) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
}


// setup collectionView
- (void)setupCollectionView{
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.itemSize = self.view.frame.size;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[XLPhotoCollectionCell class] forCellWithReuseIdentifier:photoCellReuseId];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.collectionView];
}

- (void)popSelf{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setupUIWithCurrentImgAdapter:(id<XLPhotoBrowserAdapterDelegate>)imgAdapter imageAdaptersBank:(NSArray<id<XLPhotoBrowserAdapterDelegate>> *)imageAdaptersBank{
    self.imageAdaptersBank = imageAdaptersBank;
    self.currentImgAdapter = imgAdapter;
    [self.collectionView reloadData];
}

#pragma mark - XLPhotoBrowserTapDelegate
- (void)handleTapPhotoViewWithItem:(id<XLPhotoBrowserAdapterDelegate>)item{
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleTapPhotoViewWithItem:)]) {
        [self.delegate handleTapPhotoViewWithItem:item];
    }
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageAdaptersBank.count;
}

static NSString *photoCellReuseId = @"photoCellReuseId";
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XLPhotoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoCellReuseId forIndexPath:indexPath];
    cell.imageAdapter = self.imageAdaptersBank[indexPath.row];
    cell.delegate = self;
    [cell setNeedsLayout];
    [cell layoutSubviews];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id<XLPhotoBrowserAdapterDelegate> item = self.imageAdaptersBank[indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleTapPhotoViewWithItem:)]) {
        [self.delegate handleTapPhotoViewWithItem:item];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index  = (self.collectionView.contentOffset.x + self.flowLayout.itemSize.width * 0.5) / self.flowLayout.itemSize.width;
    [self setupTitleIndexWithCurrent:index+1];
}
#pragma mark -

-(void)setupTitleIndexWithCurrent:(NSInteger)index{
    self.title = [NSString stringWithFormat:@"%@/%@",@(index),@(self.imageAdaptersBank.count)];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
