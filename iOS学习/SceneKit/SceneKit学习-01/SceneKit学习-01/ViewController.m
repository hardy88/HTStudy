//
//  ViewController.m
//  SceneKit学习-01
//
//  Created by hardy on 2017/4/25.
//  Copyright © 2017年 胡海涛. All rights reserved.
//



/*
 * SceneKit 是一个高性能的渲染游戏引擎，它能够将3D模型文件用很简单的方式渲染出来，切不需要开发着自己去写算法实现渲染。
 * OPenGL 需要开发者自己去写算法实现渲染3D文件的渲染功能。
 */

#import "ViewController.h"

#import <SceneKit/SceneKit.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    // 创建游戏专用视图
    // SCNview 只要作用是显示SceneKit的3D内容， 是UIView的子类
    SCNView *scnView = [[SCNView alloc] initWithFrame:self.view.bounds];
    
    // 创建一个场景，系统默认是没有的
    // 场景，就是放游戏元素的地方（地图，灯光，人物的游戏元素）
    scnView.scene = [SCNScene scene];
    
    scnView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:scnView];
    
    
    // 节点
   // 场景是由许多小节点组成，它有自己的位置和自身坐标系统， 我们把几何模型、灯光、摄像机的游戏中的真实元素吸附到SCNNote节点上
    // 节点就是个模型。传递数据的
    SCNNode *textNote = [SCNNode node];
    
    SCNText *text = [SCNText textWithString:@"我爱编程" extrusionDepth:0.5];
    
    textNote.geometry = text;
    
    [scnView.scene.rootNode addChildNode:textNote];
    scnView.allowsCameraControl =true;
    
    
    SCNBox *box = [SCNBox boxWithWidth:1 height:1 length:1 chamferRadius:0];
    box.firstMaterial.diffuse.contents = @"";
    
    

   /*
        SCNCamera 照相机或者摄像机，游戏就相当于一个生活中的环境，我们可以通过相机捕捉到你想要观察的画面
    
        SCNLight 灯光，我们给游戏中添加不同的灯光，来模拟逼真的环境
    
        SCNAudioSource 给游戏添加声音
    
        SCNAction 负责节点的属性、动作
    
        SCNTransaction 负责提交改变节点属性的事件，
    
        SCNGeometry 呈现三维模型的类，
    
        SCNMaterial 定义模型的外观，
    
    */
    
}


@end
