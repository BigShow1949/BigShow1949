//
//  GLIRViewController.m
//
//  Modified by Denis Berton
//  Copyright (c) 2013 clooket.com. All rights reserved.
//
//  GLIRViewController is based on gl_image_ripple (https://github.com/willstepp/gl_image_ripple)
//
//  Created by Daniel Stepp on 9/1/12.
//  Copyright (c) 2012 Monomyth Software. All rights reserved.
//

#import <CoreVideo/CVOpenGLESTextureCache.h>
#import <QuartzCore/QuartzCore.h>
#include <stdlib.h>
#import "GLIRViewController.h"

// Uniform index.
enum
{
    UNIFORM_Y,
    UNIFORM_UV,
    UNIFORM_RGB,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

// Attribute index.
enum
{
    ATTRIB_VERTEX,
    ATTRIB_TEXCOORD,
    ATTRIB_COLOR,
    NUM_ATTRIBUTES
};

@interface GLIRViewController (){
    CGFloat _screenWidth;
    CGFloat _screenHeight;
    
    unsigned int _meshFactor;

    GLuint _program;
    CVImageBufferRef _pixelBuffer;
    
    size_t _width;
    size_t _height;
    
    CVOpenGLESTextureCacheRef _textureCache;
    CVOpenGLESTextureRef _texture;
    
    GLuint _positionVBO;
    GLuint _texcoordVBO;
    GLuint _indexVBO;
    
    EAGLContext *_context;

}
@property (strong, nonatomic) EAGLContext *context;
- (CGImageRef)CGImageRotatedByAngle:(CGImageRef)imgRef angle:(CGFloat)angle;
@end

@implementation GLIRViewController
@synthesize context = _context;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    stopUdpate = NO;
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
//    self.preferredFramesPerSecond = 60;
    
    //avoid UIKit freeze
    //http://stackoverflow.com/questions/10080932/glkviewcontrollerdelegate-getting-blocked
    view.enableSetNeedsDisplay = NO;
    self.preferredFramesPerSecond = 0;
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    displayLink.frameInterval = 2;
    
    
    _screenWidth = [UIScreen mainScreen].bounds.size.width;
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
    view.contentScaleFactor = [UIScreen mainScreen].scale;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // meshFactor controls the ending ripple mesh size.
        // For example mesh width = screenWidth / meshFactor.
        // It's chosen based on both screen resolution and device size.
        _meshFactor = 8;
    }
    else
    {
        _meshFactor = 4;
    }
    
    [self setupGL];
  
    
    UIImage * myImage = [UIImage imageNamed:self.rippleImageName];
    CGImageRef imageRef = [myImage CGImage];
    imageRef = [self CGImageRotatedByAngle:imageRef angle:90.0f];
    _pixelBuffer = [self pixelBufferFromCGImage:imageRef];
    _width = CVPixelBufferGetWidth(_pixelBuffer);
    _height = CVPixelBufferGetHeight(_pixelBuffer);
    
    //-- Create CVOpenGLESTextureCacheRef for optimal CVImageBufferRef to GLES texture conversion.
    CVReturn err = CVOpenGLESTextureCacheCreate(kCFAllocatorDefault, NULL, (__bridge CVEAGLContext)((__bridge void *)_context), NULL, &_textureCache);
    if (err)  {
        NSLog(@"Error at CVOpenGLESTextureCacheCreate %d", err);
        return;
    }
}

- (void)render:(CADisplayLink*)displayLink {
    GLKView* view = (GLKView*)self.view;
    //avoid UIKit freeze    
    [self update];
    [view display];
}

- (void)cleanUpTextures
{
    if (_texture)
    {
        CFRelease(_texture);
        _texture = NULL;
    }
    
    CVOpenGLESTextureCacheFlush(_textureCache, 0);
}

- (CVPixelBufferRef) pixelBufferFromCGImage: (CGImageRef) image
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

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    
    [self loadShaders];
    
    glUseProgram(_program);
    
    glUniform1i(uniforms[UNIFORM_RGB], 0);
}

- (void)setupBuffers
{
//    glGenBuffers(1, &_indexVBO);
//    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexVBO);
//    glBufferData(GL_ELEMENT_ARRAY_BUFFER, [_ripple getIndexSize], [_ripple getIndices], GL_STATIC_DRAW);
//    
//    glGenBuffers(1, &_positionVBO);
//    glBindBuffer(GL_ARRAY_BUFFER, _positionVBO);
//    glBufferData(GL_ARRAY_BUFFER, [_ripple getVertexSize], [_ripple getVertices], GL_STATIC_DRAW);
//    
//    glEnableVertexAttribArray(ATTRIB_VERTEX);
//    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, GL_FALSE, 2*sizeof(GLfloat), 0);
//    
//    glGenBuffers(1, &_texcoordVBO);
//    glBindBuffer(GL_ARRAY_BUFFER, _texcoordVBO);
//    glBufferData(GL_ARRAY_BUFFER, [_ripple getVertexSize], [_ripple getTexCoords], GL_DYNAMIC_DRAW);
//    
//    glEnableVertexAttribArray(ATTRIB_TEXCOORD);
//    glVertexAttribPointer(ATTRIB_TEXCOORD, 2, GL_FLOAT, GL_FALSE, 2*sizeof(GLfloat), 0);
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    self.context = nil;
    
    [displayLink invalidate];
    displayLink = nil;    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClear(GL_COLOR_BUFFER_BIT);
    
//    if (_ripple)
//    {
//        unsigned int indexCount = [_ripple getIndexCount];
//        glDrawElements(GL_TRIANGLE_STRIP, indexCount, GL_UNSIGNED_SHORT, 0);
//    }
}

#pragma mark - GLKViewControllerDelegate

- (void)update
{
    if(stopUdpate)
    {
        return;
    }
    if (!_textureCache)
    {
        NSLog(@"No video texture cache");
        return;
    }
  
//    if (!_ripple)
//    {
//        [self loadImageIntoPond:self.rippleImageName];
//    }
//    
//    if (_ripple)
//    {
//        [_ripple runSimulation];
//        
//        // no need to rebind GL_ARRAY_BUFFER to _texcoordVBO since it should be still be bound from setupBuffers
//        unsigned int vertexSize = [_ripple getVertexSize];
//        GLfloat * texCoords = [_ripple getTexCoords];
//        glBufferData(GL_ARRAY_BUFFER, vertexSize, texCoords, GL_DYNAMIC_DRAW);
//    }
}

-(void)loadImageIntoPond:(NSString *)fileName
{
  [EAGLContext setCurrentContext:_context];
  
  glDeleteBuffers(1, &_positionVBO);
  glDeleteBuffers(1, &_texcoordVBO);
  glDeleteBuffers(1, &_indexVBO);
  
//  if (_ripple) _ripple = nil;
//  _ripple = [[RippleModel2 alloc] initWithScreenWidth:_screenWidth
//                                        screenHeight:_screenHeight
//                                          meshFactor:_meshFactor
//                                         touchRadius:5
//                                        textureWidth:_width
//                                       textureHeight:_height];
  [self setupBuffers];
  
  glActiveTexture(GL_TEXTURE0);
  
  // 1
  UIImage * image = [UIImage imageNamed:fileName];
  CGImageRef spriteImage = image.CGImage;
  spriteImage = [self CGImageRotatedByAngle:spriteImage angle:90.0f];
  if (!spriteImage) {
    NSLog(@"Failed to load image %@", @"image");
    exit(1);
  }
  
  // 2
  _width = CGImageGetWidth(spriteImage);
  _height = CGImageGetHeight(spriteImage);
  
  GLubyte * spriteData = (GLubyte *) calloc(_width*_height*4, sizeof(GLubyte));
  
  CGContextRef spriteContext = CGBitmapContextCreate(spriteData, _width, _height, 8, _width*4,
                                                     CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
  
  // 3
  CGContextDrawImage(spriteContext, CGRectMake(0, 0, _width, _height), spriteImage);
  CGContextRelease(spriteContext);
  
  // 4
  GLuint texName;
  glGenTextures(1, &texName);
  glBindTexture(GL_TEXTURE_2D, texName);
  
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, _width, _height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
  
  free(spriteData);
  
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
}

#pragma mark - OpenGL ES 2 shader compilation

- (BOOL)loadShaders
{
    GLuint vertShader, fragShader;
    NSString *vertShaderPathname, *fragShaderPathname;
    
    // Create shader program.
    _program = glCreateProgram();
    
    // Create and compile vertex shader.
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname])
    {
        NSLog(@"Failed to compile vertex shader");
        return NO;
    }
    
    // Create and compile fragment shader.
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname]) {
        NSLog(@"Failed to compile fragment shader");
        return NO;
    }
    
    // Attach vertex shader to program.
    glAttachShader(_program, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(_program, fragShader);
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
    glBindAttribLocation(_program, ATTRIB_VERTEX, "position");
    glBindAttribLocation(_program, ATTRIB_TEXCOORD, "texCoord");
    
    // Link program.
    if (![self linkProgram:_program]) {
        NSLog(@"Failed to link program: %d", _program);
        
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
    
    // Get uniform locations.
    uniforms[UNIFORM_RGB] = glGetUniformLocation(_program, "SamplerRGB");
    
    // Release vertex and fragment shaders.
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
    if (!source)
    {
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

-(void) cleanRipple{
//    if(_ripple){
//        _ripple = nil;
//    }
}


#pragma mark - Touch handling methods

- (void)myTouch:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInView:touch.view];
//        [_ripple initiateRippleAtLocation:location];
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
@end
