//
//  ViewController.m
//  OpenGLES学习-01
//
//  Created by hardy on 2017/5/5.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "ViewController.h"
#import <GLKit/GLKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // OpenGL 是一个跨平台的规范， 它只是提供了把物体渲染到屏幕所需的必要功能。
    // 由于OpenGL是跨平台的，而每个系统创建窗口的操作都不一样，所以我们开始使用前
    // 都必须自己创建一个窗口，定义一个环境，并自己处理所有的用户输入。
    
    
    // 在创建出炫目的图像之前，我们需要创建一个OpenGL环境，以及一个应用程序窗口

    // 1. OpenGL 窗口
    GLKView *opglView = (GLKView*)self.view;
    opglView.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    
    // 2. OpenGL 环境
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    opglView.context = context;
    [EAGLContext setCurrentContext:opglView.context];
    
    
    // 3. 设置三维图行的顶点数据
    // 顶点数据
    GLfloat vertextData[] =
    {
        0.5,  -0.5,  0.0f, 1.0f, 0.0f,
        0.5,   0.5, -0.0f, 1.0f, 1.0f,
        -0.5,  0.5,  0.0f, 0.0f, 1.0f,
        0.5,   0.5,  0.0f, 1.0f, 0.0f,
        -0.5,  0.5,  0.0f, 0.0f, 1.0f,
        -0.5,  -0.5, 0.0f, 0.0f, 0.0f,
    };
    
    //顶点缓存对象
    GLuint buffer;
    // 给顶点缓存对象一个独一无二的ID
    glGenBuffers(1, &buffer);
    // 绑定缓存对象
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    
    //glBufferData将之前的顶点数据复制带内存中
    // GL_STATIC_DRAW 告诉显卡如何管理我们给定的额数据， 数据每次绘制时都会改变
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertextData), vertextData, GL_STATIC_DRAW);
    
    
    // 设置合适的格式，从buffer里面读取数据
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat)*5, (GLfloat*)NULL +0);
    // 开启顶点属性
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    
    
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat)*5, (GLfloat*)NULL +3);
    
    // 纹理是一个2D图片，它用来添加物体的细节
    // 4. 纹理贴图
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"for_text" ofType:@"jpg"];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:@(1),GLKTextureLoaderOriginBottomLeft, nil];
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:nil];
    
    // 5. 着色器
    GLKBaseEffect *baseEffect = [[GLKBaseEffect alloc] init];
    baseEffect.texture2d0.enabled = GL_TRUE;
    baseEffect.texture2d0.name = textureInfo.name;
}


@end
