//
//  ViewController.m
//  OpenGLES学习-01
//
//  Created by hardy on 2017/5/5.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property(nonatomic,strong)GLKBaseEffect *effect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // OpenGL 是一个跨平台的规范， 它只是提供了把物体渲染到屏幕所需的必要功能。
    // 由于OpenGL是跨平台的，而每个系统创建窗口的操作都不一样，所以我们开始使用前
    // 都必须自己创建一个窗口，定义一个环境，并自己处理所有的用户输入。
    
    
    // 在创建出炫目的图像之前，我们需要创建一个OpenGL环境，以及一个应用程序窗口

    // 1. OpenGL 环境
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    // 2. OpenGL 窗口
    GLKView *opglView = (GLKView*)self.view;
    
    opglView.context = context;
    opglView.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    
    [EAGLContext setCurrentContext:context];
    // 3. 设置三维图行的顶点数据
    // 顶点数据
    GLfloat vertextData[] =
    {
        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
        0.5, 0.5, -0.0f,    1.0f, 1.0f, //右上
        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
        
        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
        -0.5, -0.5, 0.0f,   0.0f, 0.0f, //左下
    };
    
    // 将顶点数据导入到GPU中
// 使用VBO管理顶点缓存数据
    //顶点缓冲对象
    GLuint buffer;
    // 1. 给顶点缓存对象一个独一无二的ID
    glGenBuffers(1, &buffer);
    // 2. 让标示去绑定一个内存区域，但是此时，这个内存没有大小
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    
    //glBufferData将之前的顶点数据复制到显卡内存中，这个过程比较慢。所以尽量一次性把数据发过去。
    // GL_STATIC_DRAW 告诉显卡如何管理我们给定的额数据， 数据每次绘制时都会改变
    // 3. 根据顶点数组的大小，开辟内存空间，并将数据加载到显卡内存中
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertextData), vertextData, GL_STATIC_DRAW);
    // 开启顶点属性
    // 4. 启用这块内存，并标记位置
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    // 顶点属性告诉OpenGL如何把顶点数据链接到顶点着色器的顶点属性上
    // 5. 告诉GPU顶点数据在内存中的格式是怎么样的，应该如何去使用
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat)*5, (GLfloat*)NULL +0);
   
    
    
    // 纹理属性
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat)*5, (GLfloat*)NULL +3);
    
    // 纹理是一个2D图片，它用来添加物体的细节
    // 4. 纹理贴图
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"for_test" ofType:@"jpg"];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:@(1),GLKTextureLoaderOriginBottomLeft, nil];
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:nil];
    
    // 5. 着色器
    GLKBaseEffect *baseEffect = [[GLKBaseEffect alloc] init];
    baseEffect.texture2d0.enabled = GL_TRUE;
    baseEffect.texture2d0.name = textureInfo.name;
    self.effect = baseEffect;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0.3f, 0.6f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    //启动着色器
    [self.effect prepareToDraw];
    // 绘制三角形
    glDrawArrays(GL_TRIANGLES, 0, 6);
}

@end
