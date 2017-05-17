//
//  ViewController.m
//  OpenGLES--画三角形
//
//  Created by hardy on 2017/5/17.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "ViewController.h"

// 保存每个顶点的数据
typedef struct vector{
    
    GLKVector3 positionCoords;
    
}SceneVertex;

@interface ViewController ()

@property(nonatomic,strong)GLKBaseEffect *effect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1. OpenGL 环境
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    // 2. OpenGL 窗口
    GLKView *opglView = (GLKView*)self.view;
    
    opglView.context = context;
    opglView.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    
    [EAGLContext setCurrentContext:context];
    // 3. 设置三维图行的顶点数据
    // 顶点数据
    // 保存三角形3个顶点的数据
    SceneVertex vertices[] = {
        
        -0.5,-0.5,0,
        0.5,-0.5,0,
        -0.5,0.5,0
    };
    GLuint buffer;
    glGenBuffers(1, // 指定要生成的缓存标示符的数量
                 &buffer); // 缓存标示符的地址
    glBindBuffer(GL_ARRAY_BUFFER, //绑定什么类型的缓存，顶点属性数组
                 buffer); // 需要绑定的缓存标示符，标示为0表示满意缓存
    glBufferData(GL_ARRAY_BUFFER, // 初始化缓存信息
                 sizeof(vertices), // 缓存需要拷贝的大小
                 vertices, // 需要拷贝的数据
                 GL_STATIC_DRAW); // 放到GPU内存中，申明存放的类型。
    
    // 4. 启用顶点数据
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    // 告诉ES顶点数据在哪里，以及如何解释每个顶点保存的数据
    glVertexAttribPointer(GLKVertexAttribPosition, // 顶点数据
                          3, // 每个顶点包含3个数据
                          GL_FLOAT, // 顶点数据类型
                          GL_FALSE, // 固定数据。 是否归一化
                          sizeof(SceneVertex), // 步幅：每个顶点数据之间的跨度，取每个顶点数据所占的字节大小
                          NULL); // 告诉ES从当前绑定的顶点缓存的开始位置访问顶点数据
    
    
    // 5. 着色器
    GLKBaseEffect *baseEffect = [[GLKBaseEffect alloc] init];
    baseEffect.useConstantColor = GL_TRUE;
    baseEffect.constantColor = GLKVector4Make(0.0, 0, 0, 1);
    self.effect = baseEffect;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    //启动着色器
    [self.effect prepareToDraw];
    
    // 绘制三角形
    glDrawArrays(GL_TRIANGLES, // 渲染顶点数据类型
                 0, // 第一个需要渲染的顶点位置
                 3); // 渲染的顶点数量
}



@end
