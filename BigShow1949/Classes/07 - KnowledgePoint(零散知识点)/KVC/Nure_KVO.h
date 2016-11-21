//
//  Nure_KVO.h
//  BigShow1949
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Children_KVO;
@interface Nure_KVO : NSObject{
    Children_KVO *_children;
}

- (id) initWithChildren:(Children_KVO *)children;

@end
