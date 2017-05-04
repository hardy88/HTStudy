//
//  ViewController.m
//  SCNNode用法讲解
//
//  Created by hardy on 2017/4/25.
//  Copyright © 2017年 胡海涛. All rights reserved.



/*
 理解游戏节点概念
 
 
 在场景中添加节点后，就可以在节点上放我们的游戏元素
 
 节点看不见，摸不着，但是它有位置以及自身坐标系
 
 本节学习目标：
 1. 如何添加节点到场景中
 2. 给节点绑定几何物体
 3. 给节点添加节点
 
 */


#import "ViewController.h"
#import <SceneKit/SceneKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    SCNView *scnView = [[SCNView  alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    scnView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    scnView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:scnView];
    
    
    SCNScene *scene = [SCNScene scene];
    scnView.scene = scene;
    
    // add SCNNote
    SCNNode *node = [SCNNode node];
    [scene.rootNode addChildNode:node];
    
    // add Shape 给节点添加几何图形
    SCNSphere *sphere = [SCNSphere sphereWithRadius:0.5];
    node.geometry = sphere;
    
// 给节点添加子节点
    // 创建子节点，并给子节点添加几何图形
    SCNNode *chinaNode = [SCNNode node];
    // 设置节点位置
    chinaNode.position = SCNVector3Make(-0.5, 0, 1);
    // 设置几何形状，我们选择立体字体
    SCNText *text = [SCNText textWithString:@"让学习称为一种习惯" extrusionDepth:0.03];
    // 设置字体大小
    text.font = [UIFont systemFontOfSize:0.15];
    // 给节点绑定几何物体
    chinaNode.geometry = text;
    [node addChildNode:chinaNode];
    
    scnView.allowsCameraControl = true;
    
    
    
}


@end
