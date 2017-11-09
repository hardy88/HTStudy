//
//  ViewController.m
//  OpenGL ES Demo5
//
//  Created by hardy on 2017/11/9.
//  Copyright © 2017年 Hardy Hu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (nonatomic,strong) EAGLContext  *context;

@property (nonatomic,strong) GLKBaseEffect  *baseEffect;


@property (nonatomic,assign)  GLfloat time;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupContext];
    
    [self setupShowData];
    
}

- (void)setupShowData
{
    // 4.  设置数据
    
    // GLFloat类型的数组
    // 设置 顶点位置和顶点颜色
    static GLfloat showData[24] = {
          0,    0.5f,   0,   1,   0,   0,
//        -0.5,    0.5f,   0,   1,   0,   0,
        -0.5f,  -0.5f,  0,   1,   0,   0,
        0.5f,    -0.5f,  0,   1,   0,
    };
    // 将数据拷贝到显存中
    GLuint buffer;
    // 生成缓存对象
    glGenBuffers(1, &buffer);
    // 绑定缓存对象
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    // 将数据拷贝到缓存对象中
    glBufferData(GL_ARRAY_BUFFER, sizeof(showData), showData, GL_STATIC_DRAW);
    
    
    // 激活位置属性
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    // 设置顶点位置的获取
    /*
     参数意义：
     1. 设置哪种属性的数据
     2. 数据有多少个
     3. 数据类型
     4. 是否归一化，一般都填 false
     5. 每次隔多远取一次数据
     6. 数据源+开始取数据的下标。 如果已经将数据源拷贝到显存中，则可以设置为NULL; 如果没有拷贝过数据则需要设置数据源
     */
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 6, NULL);
    
    // 激活颜色属性
    glEnableVertexAttribArray(GLKVertexAttribColor);
    // 设置顶点颜色
    // 每次隔6个数据取一次颜色的数据，从第三个开始取，共有三个
    glVertexAttribPointer(GLKVertexAttribColor, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 6, (GLfloat*)NULL + 3);
}

- (void)setupContext
{
    // 1. 设置当前上下文
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.context];
    
    // 2. 设置view的属性
    GLKView  *glView = (GLKView *)self.view;
    glView.context = self.context;
    glView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    
    // 3. 着色器
    self.baseEffect = [[GLKBaseEffect alloc] init];
}
- (void)update
{
    GLKMatrix4 original = GLKMatrix4Translate(GLKMatrix4Identity, 0, 0, 0);
    static float d = 0;
    d += 0.01;
    original = GLKMatrix4RotateY(original, d);
    self.baseEffect.transform.modelviewMatrix = original;
}
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    [self.baseEffect prepareToDraw];
    // 开始渲染
    // 渲染图形  从第几个数据开始渲染  共渲染3个数据。。。注意下标是从0开始的
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 3);
}
@end
