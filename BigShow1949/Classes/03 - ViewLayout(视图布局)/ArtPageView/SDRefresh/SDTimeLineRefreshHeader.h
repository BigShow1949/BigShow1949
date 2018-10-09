//
//  SDTimeLineRefreshHeader.h
//


#import <UIKit/UIKit.h>
#import "SDBaseRefreshView.h"

@interface SDTimeLineRefreshHeader : SDBaseRefreshView

+ (instancetype)refreshHeaderWithCenter:(CGPoint)center;

@property (nonatomic, copy) void(^refreshingBlock)();

@end
