//
//  TZLMenuButtonView.h
//  DemoSet
//
//  Created by tang on 2017/11/29.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZLImageView.h"

@interface TZLMenuButtonView : UIView

@property(nonatomic, strong) NSArray *items;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image heightImage:(UIImage *)heightImage;

@end
