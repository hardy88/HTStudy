//
//  HTShaderView.m
//  OpenGLES-学习02
//
//  Created by hardy on 2017/5/11.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTShaderView.h"

#import <OpenGLES/ES2/gl.h>



@interface HTShaderView ()

// EAGLLayer
@property(nonatomic,strong)CAEAGLLayer *esLayer;
// 上下文
@property(nonatomic,strong)EAGLContext *eaContext;
// RenderBuffer
@property(nonatomic,assign)GLuint esColorRenderBuffer;
// FrameBuffer
@property(nonatomic,assign)GLuint esColorFrameBuffer;
//
@property(nonatomic,assign)GLuint esProgram;


@end


@implementation HTShaderView

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

/**
 重绘
 */
- (void)layoutSubviews
{
    
    // 设置layer
    [self configLayer];
    
    // 设置上下文（环境）
    [self configContext];
    
    // 初始化 帧缓冲
    [self destoryRenderAndFrameBuffer];
    
    // 设置帧缓冲 和 Render Buffer
    [self configRenderBufferAndFrameBuffer];
    
    // 配置自己的着色器
    [self configRender];
}

- (void)configRender
{
    glClearColor(0, 1, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    // 设置视口大小
    glViewport(self.frame.origin.x * scale, self.frame.origin.y * scale,
               self.frame.size.width *scale, self.frame.size.height *scale);
    
    // 读取文件路径
    NSString *vertFile = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    NSString *fragFile = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    
    // 加载shader
    self.esProgram = [self loadShaders:vertFile frag:fragFile];
    
    
    // 链接
    glLinkProgram(self.esProgram);
    
    GLint linkSuccess;
    glGetProgramiv(self.esProgram, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) // 链接失败
    {
        GLchar message[256];
        glGetProgramInfoLog(self.esProgram, sizeof(message), 0, &message[0]);
        NSString *messageString = [NSString stringWithUTF8String:message];
        
        NSLog(@"链接失败 %@",messageString);
        return;
    }
    else
    {
        glUseProgram(self.esProgram);
    }
    
    // 顶点数据
     GLfloat attrArr[] =
    {
        0.5f, -0.5f, -1.0f,     1.0f, 0.0f,
        -0.5f, 0.5f, -1.0f,     0.0f, 1.0f,
        -0.5f, -0.5f, -1.0f,    0.0f, 0.0f,
        0.5f, 0.5f, -1.0f,      1.0f, 1.0f,
        -0.5f, 0.5f, -1.0f,     0.0f, 1.0f,
        0.5f, -0.5f, -1.0f,     1.0f, 0.0f,
    };
    
    GLuint attrBuffer;
    glGenBuffers(1, &attrBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, attrBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(attrArr), attrArr, GL_DYNAMIC_DRAW);
    
    GLuint position = glGetAttribLocation(self.esProgram, "position");
    glVertexAttribPointer(position, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, NULL);
    glEnableVertexAttribArray(position);
    
    GLuint textCoor = glGetAttribLocation(self.esProgram, "textCoordinate");
    glVertexAttribPointer(textCoor, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (float *)NULL + 3);
    glEnableVertexAttribArray(textCoor);
    
    // 加载纹理
    [self configTexture:@"for_test"];
    
    // 获取shader里面的变量
    GLuint rotate = glGetUniformLocation(self.esProgram, "rotateMatrix");
    
    float radians = 10 * 3.14159f / 180.0f;
    float s = sin(radians);
    float c = cos(radians);
    
    //z轴旋转矩阵
    GLfloat zRotation[16] = { //
        c, -s, 0, 0.2, //
        s, c, 0, 0,//
        0, 0, 1.0, 0,//
        0.0, 0, 0, 1.0//
    };
    
    //设置旋转矩阵
    glUniformMatrix4fv(rotate, 1, GL_FALSE, (GLfloat *)&zRotation[0]);
    
    glDrawArrays(GL_TRIANGLES, 0, 6);
    
    [self.eaContext presentRenderbuffer:GL_RENDERBUFFER];
    
    
    
}

- (GLuint)configTexture:(NSString*)fileName
{
    // 1 获取图片的CGImageRef
    CGImageRef spriteImage = [UIImage imageNamed:fileName].CGImage;
    if (!spriteImage)
    {
        NSLog(@"Failed to load image %@", fileName);
        exit(1);
    }
    
    // 2. 读取图片大小
    size_t width = CGImageGetWidth(spriteImage);
    size_t height = CGImageGetHeight(spriteImage);
    
    GLubyte *spriteData = (GLubyte *)calloc(width * height * 4, sizeof(GLubyte));
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width *4, CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
    
    // 3. 在CGContextRef上绘图
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
    CGContextRelease(spriteContext);
    
    // 4. 绑定纹理到默认的纹理id
    glBindTexture(GL_TEXTURE_2D, 0);
    
    // 纹理坐标
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
    float fw = width, fh = height;
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, fw, fh, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
    
    glBindTexture(GL_TEXTURE_2D, 0);
    
    free(spriteData);
    
    return 0;
    
}

/**
着色器

 @param vert 顶底着色器
 @param frag 片元着色器
 @return
 */
- (GLuint)loadShaders:(NSString*)vert frag:(NSString*)frag
{
    GLuint verShader, fragShader;
    GLint program = glCreateProgram();
    
    // 编译
    [self compileShader:&verShader type:GL_VERTEX_SHADER file:vert];
    [self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:frag];
    
    glAttachShader(program, verShader);
    glAttachShader(program, fragShader);
    
    //释放shader
    glDeleteShader(verShader);
    glDeleteShader(fragShader);
    
    return program;
    
}

- (void)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString*)file
{
    NSString *content = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    
    const GLchar *source = (GLchar*)[content UTF8String];
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
}


- (void)configRenderBufferAndFrameBuffer
{
    GLuint buffer;
    glGenRenderbuffers(1, &buffer);
    self.esColorRenderBuffer = buffer;
    glBindRenderbuffer(GL_RENDERBUFFER, buffer);
    // 为颜色缓冲区分配存储空间
    [self.eaContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.esLayer];
    
    
    // FrameBuffer
    GLuint frameBuffer;
    glGenFramebuffers(1, &frameBuffer);
    self.esColorFrameBuffer = frameBuffer;
    glBindFramebuffer(GL_FRAMEBUFFER, self.esColorFrameBuffer);
    // ???
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, self.esColorRenderBuffer);
    
    
    
}

- (void)destoryRenderAndFrameBuffer
{
    
    GLuint colorFrameBuffer;
    GLuint colorRenderBuffer;
    
    
    glDeleteFramebuffers(1, &colorFrameBuffer);
    colorFrameBuffer = 0;
    
    glDeleteRenderbuffers(1, &colorRenderBuffer);
    
}

- (void)configLayer
{
    self.esLayer = (CAEAGLLayer*)self.layer;
    // 放大倍数
    self.contentScaleFactor = [[UIScreen mainScreen] scale];
    // CALayer 默认是透明的，必须将它设为不透明 才能可见
    self.esLayer.opaque = YES;
    
    
    // 设置描绘属性，设置不维持渲染内容以及颜色格式为RGBAB
    self.esLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
    
}

- (void)configContext
{
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if (!context)
    {
        NSLog(@"Failed to initialize OpenGLES 2.0 context");
        exit(1);
    }
    [EAGLContext setCurrentContext:context];
    
    self.eaContext = context;
}


@end
