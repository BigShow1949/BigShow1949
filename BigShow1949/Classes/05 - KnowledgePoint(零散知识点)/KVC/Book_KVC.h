//
//  Book_KVC.h
//  BigShow1949
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author_KVC.h" 

@interface Book_KVC : NSObject{
    Author_KVC *_author;
}

@property NSString *name;
@property float price;

@end
