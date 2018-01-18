//
//  ControllerButton.m
//  DemoSet
//
//  Created by tang on 2017/11/29.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "ControllerButton.h"

@implementation ControllerButton

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    if (self = [super initWithImage:image highlightedImage:highlightedImage]) {
        self.userInteractionEnabled = YES;
        self.image = image;
        self.highlightedImage = highlightedImage;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.highlighted = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(centerButtonAction)]) {
        [self.delegate centerButtonAction];
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.highlighted = YES;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.highlighted = NO;
}

@end
