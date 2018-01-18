//
//  TZLRefresh.m
//  DemoSet
//
//  Created by tang on 2017/11/8.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "TZLRefresh.h"

static const NSInteger refreshHeight = 110;
@interface TZLRefresh()

@property(nonatomic, strong) CAShapeLayer *loadingLayer;
@property(nonatomic) CGFloat progress;
@property(nonatomic) BOOL isRefreshing;

@end
@implementation TZLRefresh

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, -refreshHeight, [UIScreen mainScreen].bounds.size.width, refreshHeight);
        self.isRefreshing = NO;
        [self initUI];
    }
    return self;
}
#pragma mark- initUI
- (void)initUI {
    self.backgroundColor = [UIColor orangeColor];
    self.loadingLayer = [CAShapeLayer layer];
    self.loadingLayer.strokeColor = [UIColor grayColor].CGColor;
    self.loadingLayer.fillColor = [UIColor clearColor].CGColor;
    self.loadingLayer.lineWidth = 4.0;
    self.loadingLayer.lineDashPattern = @[@4, @4];
    
    CGFloat loadingRadius = refreshHeight * .5 * .8;
    self.loadingLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.frame.size.width * .5 - loadingRadius, self.frame.size.height * .5 - loadingRadius, loadingRadius * 2, loadingRadius * 2)].CGPath;
    [self.layer addSublayer:self.loadingLayer];
    self.loadingLayer.strokeEnd = 0.;
    
}
#pragma mark- setter
- (void)setRefreshView:(UIScrollView *)refreshView {
    _refreshView = refreshView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f, %f", scrollView.contentOffset.y, scrollView.contentInset.top);
    CGFloat offsetY = MAX(-(scrollView.contentOffset.y+scrollView.contentInset.top + 64), 0.);
    CGFloat progress = MIN(MAX(offsetY / self.frame.size.height, 0), 1.);
    self.progress = progress;
    NSLog(@"%f", progress);
    if (!self.isRefreshing) {
        self.loadingLayer.strokeEnd = progress;
    }
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (!self.isRefreshing && self.progress >= 1.0) {
        [self beginRegresh];
    }
    if (scrollView.contentOffset.y > -64) {
        [self endRefresh];
    }
}

- (void)beginRegresh {
    self.isRefreshing = YES;
    UIEdgeInsets contentInset = self.refreshView.contentInset;
    contentInset.top = refreshHeight;
    self.refreshView.contentInset = contentInset;
    
    CABasicAnimation *storeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    storeStartAnimation.fromValue = @-.8;
    storeStartAnimation.toValue = @1.0;
    
    CABasicAnimation *storeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    storeEndAnimation.fromValue = @0.0;
    storeEndAnimation.toValue = @1.0;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 1.5;
    animationGroup.repeatCount = 100;
    animationGroup.animations = @[storeStartAnimation, storeEndAnimation];
    
    [self.loadingLayer addAnimation:animationGroup forKey:nil];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(endRefresh) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer invalidate];
}

- (void)endRefresh {
    self.isRefreshing = NO;
    [UIView animateWithDuration:.4 animations:^{
        UIEdgeInsets contentInset = self.refreshView.contentInset;
        contentInset.top = 0;
        self.refreshView.contentInset = contentInset;
    }];
}

@end
