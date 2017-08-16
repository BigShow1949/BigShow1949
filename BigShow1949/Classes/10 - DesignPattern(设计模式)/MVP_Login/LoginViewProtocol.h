//
//  LoginViewProtocal.h
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

//V层
@protocol LoginViewProtocol <NSObject>

- (void)onLoginResult:(NSString*)result;
@end
