//
//  RGCardLayoutViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/3/15.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#define TAG 99
#import "RGCardLayoutViewController.h"
#import "RGCollectionViewCell.h"

@interface RGCardLayoutViewController ()

@end

@implementation RGCardLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  4;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RGCollectionViewCell *cell = (RGCollectionViewCell  *)[collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    [self configureCell:cell withIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(RGCollectionViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    UIView  *subview = [cell.contentView viewWithTag:TAG];
    [subview removeFromSuperview];
    
    switch (indexPath.section) {
        case 0:
            cell.imageView.image =  [UIImage imageNamed:@"i1.jpg"];
            cell.mainLabel.text = @"Glaciers";
            break;
        case 1:
            cell.imageView.image =  [UIImage imageNamed:@"i2.jpg"];
            cell.mainLabel.text = @"Parrots";
            break;
        case 2:
            cell.imageView.image =  [UIImage imageNamed:@"i3.jpg"];
            cell.mainLabel.text = @"Whales";
            break;
        case 3:
            cell.imageView.image =  [UIImage imageNamed:@"i4.jpg"];
            cell.mainLabel.text = @"Lake View";
            break;
        case 4:
            cell.imageView.image =  [UIImage imageNamed:@"i5.jpg"];
            break;
        default:
            break;
    }
    
}


@end
