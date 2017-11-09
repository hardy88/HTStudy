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


@property (nonatomic , assign) int mCount;


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
    // 纹理是从左下角(0,0) 右上角(1,1)
    static GLfloat showData[40] = {
        // 顶点             // 颜色     //纹理
        -0.5f, 0.5f,  0.0,   0.0f, 0.0f, 0.5f,     0.0f,   0.5f,  // 左上
        0.5f,  0.5f,  0.0,   0.0f, 0.5f, 0.0f,     0.5f,   0.5f,  // 右上
        -0.5f, -0.5f, 0.0,   0.5f, 0.0f, 1.0f,     0.0f,   0.0f,  // 左下
        0.5f,  -0.5f, 0.0,   0.0f, 0.0f, 0.5f,    0.5f,   0.0f,  // 右下
         0,      0,   1.0,   1.0f, 1.0f, 1.0f,    0.5f,   0.5f   // Z轴
    };
    // 将数据拷贝到显存中
    GLuint buffer;
    // 生成缓存对象
    glGenBuffers(1, &buffer);
    // 绑定缓存对象
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    // 将数据拷贝到缓存对象中
    glBufferData(GL_ARRAY_BUFFER, sizeof(showData), showData, GL_STATIC_DRAW);
    
    // 索引数组
    GLuint index[] = {
        0, 3, 2,
        0, 1, 3,
        0, 2, 4,
        0, 4, 1,
        2, 3, 4,
        1, 4, 3,
    };
    self.mCount= sizeof(index) /  sizeof(GLuint);
    GLuint indexBuffer;
    glGenBuffers(1, &indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(index), index, GL_STATIC_DRAW);

    
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
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 8, NULL);
    
    // 激活颜色属性
    glEnableVertexAttribArray(GLKVertexAttribColor);
    // 设置顶点颜色
    // 每次隔6个数据取一次颜色的数据，从第三个开始取，共有三个
    glVertexAttribPointer(GLKVertexAttribColor, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 8 , (GLfloat*)NULL + 3);
    
    // 激活纹理
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 8, (GLfloat*)NULL + 6);
    
    //纹理
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"路线" ofType:@"png"];
    NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:@(1), GLKTextureLoaderOriginBottomLeft, nil];
    GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:nil];
    self.baseEffect.texture2d0.enabled = GL_TRUE;
    self.baseEffect.texture2d0.name = textureInfo.name;
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
    glView.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    glView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    // 3. 着色器
    self.baseEffect = [[GLKBaseEffect alloc] init];
}
- (void)update
{
//    GLKMatrix4 original = GLKMatrix4Translate(GLKMatrix4Identity, 0, 0, 0);
//    static float d = 0;
//    d += 0.01;
//    original = GLKMatrix4RotateY(original, d);
//    self.baseEffect.transform.modelviewMatrix = original;
}
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    [self.baseEffect prepareToDraw];
    // 开始渲染
    // 渲染图形  从第几个数据开始渲染  共渲染3个数据。。。注意下标是从0开始的
    
    // 原始数据时使用
//    glDrawArrays(GL_TRIANGLE_STRIP, 0, self.mCount);
    
    // 索引时使用
     glDrawElements(GL_TRIANGLES, self.mCount, GL_UNSIGNED_INT, 0);
}
@end

