//
//  HWCollectionViewCell.m
//  自定义CollectionView布局
//
//  Created by apple on 14/12/25.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWCollectionViewCell.h"

@interface HWCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation HWCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.layer.borderWidth = 5;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.cornerRadius = 5;
}

- (void)setIndex:(NSString *)index
{
    _index = [index copy];
    
    self.label.text = index;
}
@end
