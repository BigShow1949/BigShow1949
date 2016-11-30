//
//  ClassC.h
//  test2
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ClassA,ClassB;
@interface ClassC : NSObject

-(id)initWithA:(ClassA *)A b:(ClassB *)B;

-(void)methodA;
-(void)methodB;

@end
