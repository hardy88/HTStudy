//
//  LeftVc.h
//  抽屉
//
//  Created by hardy on 16/9/23.
//  Copyright © 2016年 hardy. All rights reserved.
//

#import "HTBaseViewController.h"

@protocol LeftVcDelegate <NSObject>

-(void)LeftVcClick;

@end

@interface HTDrawerLeft : HTBaseViewController

@property(nonatomic,assign)id<LeftVcDelegate> delegate;


@end
