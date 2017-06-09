//
//  ProfileViewController.h
//  HXKS
//
//  Created by hardy on 2017/5/9.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

/*
 * 开锁匠个人基本信息设置
 */


#import "HTBaseViewController.h"

@protocol LeftVcDelegate <NSObject>

-(void)LeftVcClick;

@end


@interface ProfileViewController : HTBaseViewController

@property(nonatomic,assign)id<LeftVcDelegate> delegate;

@end
