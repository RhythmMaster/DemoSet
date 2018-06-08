//
//  TZLTabBar.m
//  DemoSet
//
//  Created by tang on 2018/6/7.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "TZLTabBar.h"

@interface TZLTabBar()
/** plus按钮 */
@property (nonatomic, weak) UIButton *plusBtn ;
@end

@implementation TZLTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
//        [plusBtn setTitle:@"发布" forState:UIControlStateNormal];
        [plusBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [plusBtn setButtonImageTitleStyle:TZLButtonImageTop padding:5];
        self.plusBtn = plusBtn;
        [plusBtn addTarget:self action:@selector(plusBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
    }
    return self;
}
- (void)plusBtnDidClick {
    NSLog(@"看看能不能点啊");
}
- (void)layoutSubviews {
    [super layoutSubviews];
    Class class = NSClassFromString(@"UITabBarButton");
    self.plusBtn.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5 - 2 * 10);
    CGRect plFrame = self.plusBtn.frame;
    plFrame.size = CGSizeMake(self.plusBtn.currentBackgroundImage.size.width, self.plusBtn.currentBackgroundImage.size.height);
    self.plusBtn.frame = plFrame;
    
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {//遍历tabbar的子控件
        if ([btn isKindOfClass:class]) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
            //每一个按钮的宽度==tabbar的五分之一
            CGFloat width = self.frame.size.width / 5;
            CGRect btnFrame = btn.frame;
            btnFrame.size.width = width;
            btnFrame.origin.x = width * btnIndex;
            btn.frame = btnFrame;
            btnIndex++;
            //如果是索引是2(从0开始的)，直接让索引++，目的就是让消息按钮的位置向右移动，空出来发布按钮的位置
            if (btnIndex == 2) {
                btnIndex++;
            }
        }
    }
    [self bringSubviewToFront:self.plusBtn];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@", NSStringFromCGPoint(point));
    
    if (self.isHidden == NO) {
        CGPoint newP = [self convertPoint:point toView:self.plusBtn];
        if ([self.plusBtn pointInside:newP withEvent:event]) {
            return self.plusBtn;
        } else {
            return [super hitTest:point withEvent:event];
        }
    }
    return [super hitTest:point withEvent:event];
}
@end
