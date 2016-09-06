//
//  RippleView.m
//  PoppleDemo
//
//  Created by LEA on 15/9/30.
//  Copyright © 2015年 LEA. All rights reserved.
//

#import "RippleView.h"
#import <CoreVideo/CVOpenGLESTextureCache.h>
#import <QuartzCore/QuartzCore.h>
#include <stdlib.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES1/gl.h>

enum
{
    UNIFORM_Y,
    UNIFORM_UV,
    UNIFORM_RGB,
    NUM_UNIFORMS
};
GLint uniforms_ripple[NUM_UNIFORMS];

enum
{
    ATTRIB_VERTEX,
    ATTRIB_TEXCOORD,
    ATTRIB_COLOR,
    NUM_ATTRIBUTES
};

@implementation RippleView

-(id)initWithFrame:(CGRect)frame context:(EAGLContext *)context
{
    self = [super initWithFrame:frame context:context];
    if (self)
    {
        self.delegate = self;
        self.context = context;
        self.drawableDepthFormat = GLKViewDrawableDepthFormat24;
        [EAGLContext setCurrentContext:context];
        
        _context = context;
        
        //按设备帧率进行渲染
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render:)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        displayLink.frameInterval = 3;
        
        //波纹大小
        _meshFactor = 4;
        [self setupGL];
        
        CGImageRef imageRef = [[UIImage imageNamed:@"home_top_bg"] CGImage];
        imageRef = [self CGImageRotatedByAngle:imageRef angle:90.0f];
        _pixelBuffer = [self pixelBufferFromCGImage:imageRef];
        _width = CVPixelBufferGetWidth(_pixelBuffer);
        _height = CVPixelBufferGetHeight(_pixelBuffer);
        
        CVReturn err = CVOpenGLESTextureCacheCreate(kCFAllocatorDefault, NULL, (__bridge CVEAGLContext)((__bridge void *)_context), NULL, &_textureCache);
        if (err)  {
            NSLog(@"Error at CVOpenGLESTextureCacheCreate %d", err);
        }
    }
    return self;
}

#pragma mark - 初始化
- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    [self loadShaders];
    glUseProgram(_program);
    glUniform1i(uniforms_ripple[UNIFORM_RGB], 0);
}

- (void)setupBuffers
{
    glGenBuffers(1, &_indexVBO);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexVBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, [_ripple getIndexSize], [_ripple getIndices], GL_STATIC_DRAW);
    
    glGenBuffers(1, &_positionVBO);
    glBindBuffer(GL_ARRAY_BUFFER, _positionVBO);
    glBufferData(GL_ARRAY_BUFFER, [_ripple getVertexSize], [_ripple getVertices], GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, GL_FALSE, 2*sizeof(GLfloat), 0);
    
    glGenBuffers(1, &_texcoordVBO);
    glBindBuffer(GL_ARRAY_BUFFER, _texcoordVBO);
    glBufferData(GL_ARRAY_BUFFER, [_ripple getVertexSize], [_ripple getTexCoords], GL_DYNAMIC_DRAW);
    
    glEnableVertexAttribArray(ATTRIB_TEXCOORD);
    glVertexAttribPointer(ATTRIB_TEXCOORD, 2, GL_FLOAT, GL_FALSE, 2*sizeof(GLfloat), 0);
}

- (void)render:(CADisplayLink*)displayLink
{
    GLKView* view = (GLKView*)self;
    [self update];
    [view display];
}

#pragma mark - GLKViewDelegate
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClear(GL_COLOR_BUFFER_BIT);
    if (_ripple){
        unsigned int indexCount = [_ripple getIndexCount];
        glDrawElements(GL_TRIANGLE_STRIP, indexCount, GL_UNSIGNED_SHORT, 0);
    }
}

#pragma mark - methods
- (void)update
{
    if(stopUdpate){
        return;
    }
    if (!_textureCache){
        return;
    }
    if (!_ripple){
        [self loadImageIntoPond:@"home_top_bg"];
    }
    if (_ripple)
    {
        [_ripple runSimulation];
        unsigned int vertexSize = [_ripple getVertexSize];
        GLfloat * texCoords = [_ripple getTexCoords];
        glBufferData(GL_ARRAY_BUFFER, vertexSize, texCoords, GL_DYNAMIC_DRAW);
    }
}

-(void)loadImageIntoPond:(NSString *)fileName
{
    [EAGLContext setCurrentContext:_context];
    glDeleteBuffers(1, &_positionVBO);
    glDeleteBuffers(1, &_texcoordVBO);
    glDeleteBuffers(1, &_indexVBO);
    
    if (_ripple) _ripple = nil;
    _ripple = [[RippleModel alloc] initWithScreenWidth:self.frame.size.width
                                          screenHeight:self.frame.size.height
                                            meshFactor:_meshFactor
                                           touchRadius:3
                                          textureWidth:_width
                                         textureHeight:_height];
    [self setupBuffers];
    glActiveTexture(GL_TEXTURE0);
    UIImage * image = [UIImage imageNamed:fileName];
    CGImageRef spriteImage = image.CGImage;
    spriteImage = [self CGImageRotatedByAngle:spriteImage angle:90.0f];
    if (!spriteImage) {
        exit(1);
    }
    _width = CGImageGetWidth(spriteImage);
    _height = CGImageGetHeight(spriteImage);
    GLubyte * spriteData = (GLubyte *) calloc(_width*_height*4, sizeof(GLubyte));
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, _width, _height, 8, _width*4,
                                                       CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, _width, _height), spriteImage);
    CGContextRelease(spriteContext);
    GLuint texName;
    glGenTextures(1, &texName);
    glBindTexture(GL_TEXTURE_2D, texName);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, _width, _height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
    free(spriteData);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
}

- (CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef) image
{
    CGSize frameSize = CGSizeMake(CGImageGetWidth(image), CGImageGetHeight(image));
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:NO], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:NO], kCVPixelBufferCGBitmapContextCompatibilityKey,
                             nil];
    CVPixelBufferRef pxbuffer = NULL;
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, frameSize.width,
                                          frameSize.height,  kCVPixelFormatType_32BGRA, (__bridge CFDictionaryRef) options,
                                          &pxbuffer);
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pxdata, frameSize.width,
                                                 frameSize.height, 8, 4*frameSize.width, rgbColorSpace,
                                                 kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image),
                                           CGImageGetHeight(image)), image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    return pxbuffer;
}

- (CGImageRef)CGImageRotatedByAngle:(CGImageRef)imgRef angle:(CGFloat)angle
{
    CGFloat angleInRadians = angle * (M_PI / 180);
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGRect imgRect = CGRectMake(0, 0, width, height);
    CGAffineTransform transform = CGAffineTransformMakeRotation(angleInRadians);
    CGRect rotatedRect = CGRectApplyAffineTransform(imgRect, transform);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL,
                                                   rotatedRect.size.width,
                                                   rotatedRect.size.height,
                                                   8,
                                                   0,
                                                   colorSpace,
                                                   kCGImageAlphaPremultipliedFirst);
    CGContextSetAllowsAntialiasing(bmContext, YES);
    CGContextSetInterpolationQuality(bmContext, kCGInterpolationHigh);
    CGColorSpaceRelease(colorSpace);
    CGContextTranslateCTM(bmContext,
                          +(rotatedRect.size.width/2),
                          +(rotatedRect.size.height/2));
    CGContextRotateCTM(bmContext, angleInRadians);
    CGContextDrawImage(bmContext, CGRectMake(-width/2, -height/2, width, height),
                       imgRef);
    
    CGImageRef rotatedImage = CGBitmapContextCreateImage(bmContext);
    CFRelease(bmContext);
    
    return rotatedImage;
}

#pragma mark - OpenGL ES 2 shader compilation
- (BOOL)loadShaders
{
    GLuint vertShader, fragShader;
    NSString *vertShaderPathname, *fragShaderPathname;
    _program = glCreateProgram();
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname]) {
        return NO;
    }
    
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname]) {
        return NO;
    }
    glAttachShader(_program, vertShader);
    glAttachShader(_program, fragShader);
    glBindAttribLocation(_program, ATTRIB_VERTEX, "position");
    glBindAttribLocation(_program, ATTRIB_TEXCOORD, "texCoord");
    
    if (![self linkProgram:_program])
    {
        if (vertShader) {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader) {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (_program) {
            glDeleteProgram(_program);
            _program = 0;
        }
        return NO;
    }
    uniforms_ripple[UNIFORM_RGB] = glGetUniformLocation(_program, "SamplerRGB");
    if (vertShader) {
        glDetachShader(_program, vertShader);
        glDeleteShader(vertShader);
    }
    if (fragShader) {
        glDetachShader(_program, fragShader);
        glDeleteShader(fragShader);
    }
    return YES;
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source) {
        NSLog(@"Failed to load vertex shader");
        return NO;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0) {
        glDeleteShader(*shader);
        return NO;
    }
    return YES;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
    glLinkProgram(prog);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    return YES;
}

-(void) cleanRipple
{
    if(_ripple){
        _ripple = nil;
    }
}

#pragma mark - Touch handle
- (void)myTouch:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInView:touch.view];
        [_ripple initiateRippleAtLocation:location];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self myTouch:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self myTouch:touches withEvent:event];
}

#pragma mark - dealloc
- (void)dealloc
{
    [self tearDownGL];
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    [displayLink invalidate];
    displayLink = nil;
}


- (void)tearDownGL
{
    [EAGLContext setCurrentContext:_context];
    
    glDeleteBuffers(1, &_positionVBO);
    glDeleteBuffers(1, &_texcoordVBO);
    glDeleteBuffers(1, &_indexVBO);
    
    if (_program) {
        glDeleteProgram(_program);
        _program = 0;
    }
}

- (void)cleanUpTextures
{
    if (_texture) {
        CFRelease(_texture);
        _texture = NULL;
    }
    CVOpenGLESTextureCacheFlush(_textureCache, 0);
}

@end
