//
//  TZLImageView.m
//  DemoSet
//
//  Created by tang on 2017/11/29.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "TZLImageView.h"
@interface TZLImageView ()
@property(nonatomic, strong) UIImageView *itemView;
@end
@implementation TZLImageView

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage backgroundImage:(UIImage *)backgroundImage backgroundHighlightedImage:(UIImage *)backgroundHighlightedImage {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height);
        self.image = backgroundImage;
        self.highlightedImage = backgroundHighlightedImage;
        
        self.itemView = [[UIImageView alloc] initWithImage:image highlightedImage:highlightedImage];
        self.itemView.center = CGPointMake(self.frame.size.width * .5, self.frame.size.height * .5);
        [self addSubview:self.itemView];
    }
    return self;
}

@end
