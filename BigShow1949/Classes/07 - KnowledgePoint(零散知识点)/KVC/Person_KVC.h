//
//  Person_KVC.h
//  BigShow1949
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog_KVC.h"

@interface Person_KVC : NSObject{
@private
    NSString  *_name;
    NSInteger *age;
    
    Dog_KVC   *_dog;
    
    /*
     Person类中我们定义了两个属性，但是这两个属性对外是不可访问的，而且也没有对应的get/set方法。我们也实现了description方法，用于打印结果
     */

}

@end
