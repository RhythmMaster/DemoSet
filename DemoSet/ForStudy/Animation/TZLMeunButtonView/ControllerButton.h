//
//  ControllerButton.h
//  DemoSet
//
//  Created by tang on 2017/11/29.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ControllerButtonDelegate <NSObject>

- (void)centerButtonAction;

@end

@interface ControllerButton : UIImageView
@property(nonatomic, weak) id<ControllerButtonDelegate> delegate ;
@end
