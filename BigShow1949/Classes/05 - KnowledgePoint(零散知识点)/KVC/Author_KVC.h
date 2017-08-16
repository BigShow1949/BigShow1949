//
//  Author_KVC.h
//  BigShow1949
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Author_KVC : NSObject{
    NSString *_name;
    
    //作者出版的书,一个作者对应多个书籍对象
    NSArray *_issueBook;
}

@end
