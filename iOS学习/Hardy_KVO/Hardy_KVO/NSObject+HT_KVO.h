//
//  NSObject+HT_KVO.h
//  Hardy_KVO
//
//  Created by hardy on 2017/12/18.
//  Copyright © 2017年 Hardy Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HT_KVO)

- (void)ht_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end
