//
//  YFLoginViewController.h
//  BigShow1949
//
//  Created by big show on 2018/12/11.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFLoginViewDelegate.h"
#import "YFViperView.h"
#import "YFLoginViewProtocol.h"

@interface YFLoginViewController : UIViewController<YFViperView, YFLoginViewProtocol>
@property (nonatomic, weak) id<YFLoginViewDelegate> delegate;
@property (nonatomic, copy, nullable) NSString *message;
@end
