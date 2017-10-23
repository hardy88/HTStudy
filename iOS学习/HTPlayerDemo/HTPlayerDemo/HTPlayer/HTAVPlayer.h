//
//  HTAVPlayer.h
//  TBPlayer
//
//  Created by hardy on 2017/10/20.
//  Copyright © 2017年 . All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HTAVPlayer : UIView

@property (nonatomic,strong) NSURL  *urlPath;

- (void)play;

- (void)stop;

- (void)pause;

@end
