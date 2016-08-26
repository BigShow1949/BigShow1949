//
//  GZView.m
//  Picture
//
//  Created by demo on 16/1/21.
//  Copyright © 2016年 GuZhiQiang. All rights reserved.
//

#import "GZView.h"
#import "UIImage+Extend.h"

@interface GZView()
/**
 *  图片数组
 */
@property (nonatomic,strong) NSMutableArray *images;
/**
 *  即将要删除的图片
 */
@property (nonatomic,strong) NSMutableArray *deleteImages;
@end

 

@implementation GZView

- (NSMutableArray *)images {
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (NSMutableArray *)deleteImages {
    if (_deleteImages == nil) {
        _deleteImages = [NSMutableArray array];
    }
    return _deleteImages;
    
}

//不起作用
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
        //一启动界面有钱包
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(setupImage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    }
    return self;
    
}

- (void)drawRect:(CGRect)rect {
    for (UIImage *image in self.images) {
        if (image.direction == CZImageDirectionLeft) { // 向左
            image.x -= 10;
        } else { // 向右
            image.x += 10;
        }
        // 获得x方向的随着
        image.y += arc4random_uniform(10) + 10;
        [image drawAtPoint:CGPointMake(image.x, image.y)];
        
        // 判断图片的x值是否大于屏幕宽度-自身的宽度  或者是等于0
        if(image.x >= rect.size.width - image.size.width || image.x <= 0) {
            // 方向取反
            image.direction = !image.direction;
        }
        
        // 判断图片的y值是否超出屏幕的高度
        // 注意：在遍历可变数组或字典时，不能删除里面的元素
        if(image.y > rect.size.height) {
            [self.deleteImages addObject:image];
        }
    }
    // 删除超出屏幕的图片
    for (UIImage *image in self.deleteImages) {
        [self.images removeObject:image];
    }
    [self.deleteImages removeAllObjects];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(setupImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}



- (void)setupImage {
    if (self.images.count < 10) {
        // 创建图片
        //        UIImage *image = [UIImage imageNamed:@"gift"]; // 有缓存
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gift@2x.png" ofType:nil]];
        
        image.x = arc4random_uniform(self.frame.size.width - image.size.width);
        image.direction = arc4random_uniform(2);// 0,1
        [self.images addObject:image];
    }
    // 通知重新绘制
    [self setNeedsDisplay];
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com