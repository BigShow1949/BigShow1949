//
//  YFBlurtView.h
//  BigShow1949
//
//  Created by zhht01 on 16/1/14.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SelectRowAction)(NSIndexPath *);
@interface YFBlurtView : UIView
{
    SelectRowAction selectAction;
}
@property (nonatomic,assign)CGFloat headerImgHeight;
@property (nonatomic,assign)CGFloat iconHeight;
/**
 *  图片url
 */
@property (nonatomic,copy)NSString *imgUrl;
@property (nonatomic,copy)NSString *name;

- (instancetype)initWithFrame:(CGRect)frame WithHeaderImgHeight:(CGFloat)headerImgHeight iconHeight:(CGFloat)iconHeight selectBlock:(SelectRowAction)block;
@end
