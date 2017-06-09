//
//  HTNavigationController.h
//  HTHXBB
//
//  Created by hardy on 17/1/22.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTNavigationController : UINavigationController

/**
 上一页
 */
- (void)toBakc;

/**
 下一页
 */
- (void)toNext:(UIViewController*)vc;




@end
