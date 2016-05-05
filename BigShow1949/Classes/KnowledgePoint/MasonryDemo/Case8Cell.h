//
//  Case8Cell.h
//  MasonryExample
//
//  Created by zorro on 15/12/5.
//  Copyright © 2015年 tutuge. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Case8DataEntity;
@class Case8Cell;

@protocol Case8CellDelegate <NSObject>
- (void)case8Cell:(Case8Cell *)cell switchExpandedStateWithIndexPath:(NSIndexPath *)index;
@end

@interface Case8Cell : UITableViewCell
@property (weak, nonatomic) id <Case8CellDelegate> delegate;

- (void)setEntity:(Case8DataEntity *)entity indexPath:(NSIndexPath *)indexPath;
@end
