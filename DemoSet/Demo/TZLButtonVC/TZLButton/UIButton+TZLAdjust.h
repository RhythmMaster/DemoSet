//
//  UIButton+TZLAdjust.h
//  DemoSet
//
//  Created by tang on 2018/5/29.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TZLButtonStyle){
    TZLButtonImageLeft = 0,   //图片在左
    TZLButtonImageRight = 1,  //图片在右
    TZLButtonImageTop = 2,    //图片在上
    TZLButtonImageBottom = 3, //图片在下
};

@interface UIButton (TZLAdjust)
/**
 调整按钮的文本和image的布局，前提是title和image同时存在才会调整。
 padding是调整布局时整个按钮和图文的间隔。
 */
-(void)setButtonImageTitleStyle:(TZLButtonStyle)style padding:(CGFloat)padding;

@end
