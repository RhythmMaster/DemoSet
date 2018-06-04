//
//  UIButton+TZLAdjust.m
//  DemoSet
//
//  Created by tang on 2018/5/29.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "UIButton+TZLAdjust.h"

@implementation UIButton (TZLAdjust)
- (void)setButtonImageTitleStyle:(TZLButtonStyle)style padding:(CGFloat)padding {
    //先还原
    self.titleEdgeInsets = UIEdgeInsetsZero;
    self.imageEdgeInsets = UIEdgeInsetsZero;
    
    //先让父view调用layoutIfNeeded 使父视图立即布局,以便获取self的frame
    [self.superview layoutIfNeeded];
    
    CGRect frame = self.frame;
    CGRect imageRect = self.imageView.frame;
    CGRect titleRect = self.titleLabel.frame;
    CGFloat selfWidth = frame.size.width; //按钮控件的宽度
    CGFloat selfHeight = frame.size.height; //按钮控件的高度
    CGFloat totalHeight = titleRect.size.height + padding + imageRect.size.height; //图文上下布局时所占用的总高度，注意这里也算上他们之间的间隔值padding
    NSLog(@"%@", NSStringFromCGRect(frame));
    switch (style) {
        case TZLButtonImageLeft:
            self.titleEdgeInsets = UIEdgeInsetsMake(0, padding / 2, 0, -padding / 2);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -padding / 2, 0, padding / 2);
            break;
        case TZLButtonImageRight:
            //图片在右，文字在左
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageRect.size.width + padding / 2), 0, (imageRect.size.width + padding / 2));
            self.imageEdgeInsets = UIEdgeInsetsMake(0, (titleRect.size.width + padding / 2), 0, -(titleRect.size.width + padding / 2));
            break;
        case TZLButtonImageTop:
            //图片在上，文字在下
            self.titleEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 + imageRect.size.height + padding - titleRect.origin.y),
                                              (selfWidth/2 - titleRect.origin.x - titleRect.size.width /2) - (selfWidth - titleRect.size.width) /2,
                                              -((selfHeight - totalHeight)/2 + imageRect.size.height + padding - titleRect.origin.y),
                                              -(selfWidth/2 - titleRect.origin.x - titleRect.size.width /2) - (selfWidth - titleRect.size.width) /2);
            
            self.imageEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 - imageRect.origin.y),
                                              (selfWidth /2 - imageRect.origin.x - imageRect.size.width /2),
                                              -((selfHeight - totalHeight)/2 - imageRect.origin.y),
                                              -(selfWidth /2 - imageRect.origin.x - imageRect.size.width /2));
            break;
        case TZLButtonImageBottom:
            self.titleEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 - titleRect.origin.y),
                                              (selfWidth/2 - titleRect.origin.x - titleRect.size.width /2) - (selfWidth - titleRect.size.width) /2,
                                              -((selfHeight - totalHeight)/2 - titleRect.origin.y),
                                              -(selfWidth/2 - titleRect.origin.x - titleRect.size.width /2) - (selfWidth - titleRect.size.width) /2);
            
            self.imageEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 + titleRect.size.height + padding - imageRect.origin.y),
                                              (selfWidth /2 - imageRect.origin.x - imageRect.size.width /2),
                                              -((selfHeight - totalHeight)/2 + titleRect.size.height + padding - imageRect.origin.y),
                                              -(selfWidth /2 - imageRect.origin.x - imageRect.size.width /2));
            break;
        default:
            break;
    }
    self.contentEdgeInsets = UIEdgeInsetsMake((totalHeight - selfHeight) / 2 + 5, padding / 2, (totalHeight - selfHeight) / 2 + 5, padding / 2);
}
@end
