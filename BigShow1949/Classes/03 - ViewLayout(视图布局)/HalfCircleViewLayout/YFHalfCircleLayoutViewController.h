//
//  YFHalfCircleLayoutViewController.h
//  BigShow1949
//
//  Created by zhht01 on 16/3/16.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFHalfCircleLayoutViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
//@property (nonatomic, weak) IBOutlet UIBarButtonItem *editBtn;
@property NSArray *items;
@end
