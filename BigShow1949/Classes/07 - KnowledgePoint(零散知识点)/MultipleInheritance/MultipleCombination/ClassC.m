//
//  ClassC.m
//  test2
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ClassC.h"
#import "ClassA.h"
#import "ClassB.h"

@interface ClassC()
@property (nonatomic, strong) ClassA *a;
@property (nonatomic, strong) ClassB *b;

@end
@implementation ClassC

-(id)initWithA:(ClassA *)A b:(ClassB *)B{
    self = [[ClassC alloc] init];
    self.a = A;
    self.b = B;
    return self;
}

-(void)methodA{
    
    [self.a methodA];
}
-(void)methodB{
    
    [self.b methodB];
}

@end
