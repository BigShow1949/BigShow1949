//
//  CounterRepositoryProtocol.h
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CounterRepositoryProtocol <NSObject>

-(NSInteger)getCurrentValue;
-(void)setCurrentValue:(NSInteger)value;

@end
