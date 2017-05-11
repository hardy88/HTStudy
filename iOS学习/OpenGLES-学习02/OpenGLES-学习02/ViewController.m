//
//  ViewController.m
//  OpenGLES-学习02
//
//  Created by hardy on 2017/5/5.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

/*
 * 绘制三角形
 */

/*
 * 学习着色器， 不才用GLKBaseEffect, 自己写着色器程序 shader
 
 * 着色器主要类有 glCompileShader, glAttachShader、gllinkProgram三个
 
 */



#import "ViewController.h"
#import "HTShaderView.h"

@interface ViewController ()

@property(nonatomic,strong)HTShaderView *shaderView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shaderView = (HTShaderView*)self.view;
    
}




@end
