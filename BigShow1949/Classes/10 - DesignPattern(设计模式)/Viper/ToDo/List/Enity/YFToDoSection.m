//
//  YFToDoSection.m
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFToDoSection.h"
@interface YFToDoSection()
@property (nonatomic, copy) NSString*   name;
@property (nonatomic, copy) NSString*   imageName;
@property (nonatomic, copy) NSArray*    items;
@end

@implementation YFToDoSection
+ (instancetype)sectionWithName:(NSString *)name imageName:(NSString *)imageName items:(NSArray *)items {
    YFToDoSection *section = [[YFToDoSection alloc] init];
    
    section.name = name;
    section.imageName = imageName;
    section.items = items;
    
    return section;
}
@end
