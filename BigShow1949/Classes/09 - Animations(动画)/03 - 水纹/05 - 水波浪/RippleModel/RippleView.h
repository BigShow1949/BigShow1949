//
//  RippleView.h
//  PoppleDemo
//
//  Created by LEA on 15/9/30.
//  Copyright © 2015年 LEA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "RippleModel.h"

@interface RippleView : GLKView<GLKViewDelegate>
{
    CADisplayLink               * displayLink;
    BOOL                        stopUdpate;
    
    CGFloat _screenWidth;
    CGFloat _screenHeight;
    
    unsigned int _meshFactor;
    
    GLuint                      _program;
    CVImageBufferRef            _pixelBuffer;
    CVOpenGLESTextureCacheRef   _textureCache;
    CVOpenGLESTextureRef        _texture;
    GLuint                      _positionVBO;
    GLuint                      _texcoordVBO;
    GLuint                      _indexVBO;
    size_t                      _width;
    size_t                      _height;
    EAGLContext                 *_context;
}

@property (nonatomic,strong) RippleModel *ripple;

- (CGImageRef)CGImageRotatedByAngle:(CGImageRef)imgRef angle:(CGFloat)angle;
- (void)render:(CADisplayLink*)displayLink;
- (void)cleanRipple;

@end
