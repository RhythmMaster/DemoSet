//
//  CustomTransitionAnimation.h
//  DemoSet
//
//  Created by tang on 2018/1/17.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>
- (instancetype)initWithFlag:(BOOL)flag;
@end
