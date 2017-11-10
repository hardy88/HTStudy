//
//  ViewController.m
//  OpenGL ES Demo7
//
//  Created by hardy on 2017/11/10.
//  Copyright © 2017年 Hardy Hu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) EAGLContext *context;

@property (nonatomic,strong) GLKBaseEffect  *baseEffect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupContext];
    
    [self setupData];
    
    
}


#pragma mark --
- (void)update
{
//    GLKMatrix4 original = GLKMatrix4Translate(GLKMatrix4Identity, 0, 0, 0);
//    static float d = 0;
//    d += 0.01;
//    original = GLKMatrix4RotateZ(original, d);
//     original = GLKMatrix4RotateY(original, d);
//    original = GLKMatrix4RotateX(original, d);
//    self.baseEffect.transform.modelviewMatrix = original;
    
    static float d = 0;
    d += 0.01;
    float varyingFactor = (sin(d) + 1) / 2.0; // 0 ~ 1

    GLKMatrix4 rotateMatrix = GLKMatrix4MakeRotation(varyingFactor * M_PI * 2, 1, 1, 1);
    self.baseEffect.transform.modelviewMatrix = rotateMatrix;

}
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
            
    [self.baseEffect prepareToDraw];
    
    glDrawArrays(GL_TRIANGLES, 0, 36);
}


#pragma mark --
- (void)setupContext
{
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.context];
    
    GLKView *glKView = (GLKView *)self.view;
    glKView.context = self.context;
    glKView.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    
    glEnable(GL_DEPTH_TEST);
}
- (void)setupData
{
    static GLfloat vboArr[6*6*6] = {
        // X轴0.5处的平面
        0.5,  -0.5,    0.5f, 1,  0,  0,
        0.5,  -0.5f,  -0.5f, 1,  0,  0,
        0.5,  0.5f,   -0.5f, 1,  0,  0,

        0.5,  0.5,    -0.5f, 1,  0,  0,
        0.5,  0.5f,    0.5f, 1,  0,  0,
        0.5,  -0.5f,   0.5f, 1,  0,  0,
        // X轴-0.5处的平面
        -0.5,  -0.5,    0.5f, 1,  0,  0,
        -0.5,  -0.5f,  -0.5f, 1,  0,  0,
        -0.5,  0.5f,   -0.5f, 1,  0,  0,
        -0.5,  0.5,    -0.5f, 1,  0,  0,
        -0.5,  0.5f,    0.5f, 1,  0,  0,
        -0.5,  -0.5f,   0.5f, 1,  0,  0,
        // Y轴
        -0.5,  0.5,  0.5f, 0,  1,  0,
        -0.5f, 0.5, -0.5f, 0,  1,  0,
        0.5f, 0.5,  -0.5f, 0,  1,  0,
        0.5,  0.5,  -0.5f, 0,  1,  0,
        0.5f, 0.5,   0.5f, 0,  1,  0,
        -0.5f, 0.5,  0.5f, 0,  1,  0,
        
        -0.5, -0.5,   0.5f, 0,  1,  0,
        -0.5f, -0.5, -0.5f, 0,  1,  0,
        0.5f, -0.5,  -0.5f, 0,  1,  0,
        0.5,  -0.5,  -0.5f, 0,  1,  0,
        0.5f, -0.5,   0.5f, 0,  1,  0,
        -0.5f, -0.5,  0.5f, 0,  1,  0,
        // Z轴
        -0.5,   0.5f,  0.5,   0,  0,  1,
        -0.5f,  -0.5f,  0.5,  0,  0,  1,
        0.5f,   -0.5f,  0.5,  0,  0,  1,
        
        0.5,    -0.5f, 0.5,   0,  0,  1,
        0.5f,  0.5f,   0.5,    0,  0,  1,
        -0.5f,   0.5f,  0.5,  0,  0,  1,
        
        -0.5,   0.5f,  -0.5,   0,  0,  1,
        -0.5f,  -0.5f,  -0.5,  0,  0,  1,
        0.5f,   -0.5f,  -0.5,  0,  0,  1,
        0.5,    -0.5f, -0.5,   0,  0,  1,
        0.5f,  0.5f,  -0.5,    0,  0,  1,
        -0.5f,   0.5f,  -0.5,  0,  0,  1,
    };
    
    GLuint buffer;
    glGenBuffers(1, &buffer);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vboArr), vboArr, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 6, NULL );
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 6, (GLfloat*)NULL + 3);
    
}

@end
