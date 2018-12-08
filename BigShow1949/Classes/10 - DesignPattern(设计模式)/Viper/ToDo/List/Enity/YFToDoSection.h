//
//  YFToDoSection.h
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFToDoSection : NSObject
@property (nonatomic, readonly, copy)   NSString*   name;
@property (nonatomic, readonly, copy)   NSString*   imageName;
@property (nonatomic, readonly, copy)   NSArray*    items;  // array of VTDUpcomingDisplayItem

+ (instancetype)sectionWithName:(NSString *)name imageName:(NSString *)imageName items:(NSArray *)items;
@end
