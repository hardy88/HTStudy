//
//  ViewController.m
//  SCNLight
//
//  Created by hardy on 2017/4/25.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

/*
 * 光的理解
 */


/*
 * 四种光
 
 1. 环境光SCNLightTypeAmbient
    没有方向。位置再无穷远处，光均匀的散射到物体上
 
 2. 点光源 SCNLightTypeOmni
    有固定位置，方向360度，可以衰减
 
 3. 平行方向光SCNLightTypeDirectional
    只有照射方向，没有位置，没有衰减
 
 
 4.聚焦光源 SCNLightTypeSpot
   有固定位置，也有方向，有照射区域，也有衰减
 
 
 */



#import "ViewController.h"
#import <SceneKit/SceneKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    SCNView *scnView = [[SCNView alloc] initWithFrame:self.view.bounds];
    scnView.backgroundColor = [UIColor blackColor];
    scnView.allowsCameraControl = true;
    [self.view addSubview:scnView];
    
    
    
    // 添加场景
    scnView.scene = [SCNScene scene];

    // 创建正方体
    SCNBox *box = [SCNBox boxWithWidth:0.5 height:0.5 length:0.5 chamferRadius:0];
    //创建球体
    SCNSphere *sphere = [SCNSphere sphereWithRadius:0.1];
    
    
    //把两个结合体绑定到节点上
    SCNNode *boxNote = [SCNNode node];
    boxNote.geometry =  box;
    boxNote.position = SCNVector3Make(0, 0, -11);
    
    SCNNode *sphereNode = [SCNNode node];
    sphereNode.geometry = sphere;
    sphereNode.position = SCNVector3Make(0, 0, -10);
    
    [scnView.scene.rootNode addChildNode:boxNote];
    [scnView.scene.rootNode addChildNode:sphereNode];
    
    
    // 添加环境光
    SCNLight *light = [SCNLight light];
    light.type = SCNLightTypeSpot;
    light.color = [UIColor yellowColor];
    light.castsShadow = true;
    
    SCNNode *lightNode = [SCNNode node];
    lightNode.position = SCNVector3Make(0, 0, 9);
    lightNode.light = light;
//    lightNode.rotation = SCNVector4Make(1, 0, 0, -M_PI / 2.0);
    [scnView.scene.rootNode addChildNode:lightNode];
}


@end
