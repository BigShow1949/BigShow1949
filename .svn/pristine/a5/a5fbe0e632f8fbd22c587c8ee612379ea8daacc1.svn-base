//
//  ZTypewriteEffectLabel.h
//  ZTypewriteEffect
//
//  Created by mapboo on 7/27/14.
//  Copyright (c) 2014 mapboo. All rights reserved.
//
/** 打印机输出特效
 *  项目使用实例：让图说 -会说话的记忆
    https://itunes.apple.com/cn/app/rang-tu-shuo-hui-shuo-hua/id903702019?l=en&mt=8
 *	Z
 *  iOS中国开发者（262091386） 群主
 *  个人开发者梦工厂- 微推（http://www.micropush.cn）
 */


#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

typedef void (^ZTypewriteEffectBlock)(void);

@interface ZTypewriteEffectLabel : UILabel
{
    SystemSoundID  soundID;
}

/** Z
 *	设置单个字打印间隔时间，默认 0.3 秒
 */
@property (nonatomic) NSTimeInterval typewriteTimeInterval;

/** Z
 *	开始打印的位置索引，默认为0，即从头开始
 */
@property (nonatomic) int currentIndex;

/** Z
 *	输入字体的颜色
 */
@property (nonatomic, strong) UIColor *typewriteEffectColor;

/** Z
 *	是否有打印的声音,默认为 YES
 */
@property (nonatomic) BOOL hasSound;

/** Z
 *	打印完成后的回调block
 */
@property (nonatomic, copy) ZTypewriteEffectBlock typewriteEffectBlock;

/** Z
 *  开始打印
 */
-(void)startTypewrite;

@end
