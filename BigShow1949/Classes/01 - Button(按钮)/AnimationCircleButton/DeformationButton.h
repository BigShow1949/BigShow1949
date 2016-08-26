//
//  DeformationButton.h
//  DeformationButton
//
//  Created by LuciusLu on 15/3/16.
//  Copyright (c) 2015年 MOZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMMaterialDesignSpinner.h"

@interface DeformationButton : UIControl

@property(nonatomic, assign)BOOL isLoading;
@property(nonatomic, retain)MMMaterialDesignSpinner *spinnerView;
@property(nonatomic, retain)UIColor *contentColor;
@property(nonatomic, retain)UIColor *progressColor;

@property(nonatomic, retain)UIButton *forDisplayButton;

@end
