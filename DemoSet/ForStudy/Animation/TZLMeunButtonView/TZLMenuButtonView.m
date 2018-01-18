//
//  TZLMenuButtonView.m
//  DemoSet
//
//  Created by tang on 2017/11/29.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "TZLMenuButtonView.h"
#import "ControllerButton.h"

#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.height)

@interface TZLMenuButtonView() <ControllerButtonDelegate>

@property(nonatomic, strong) ControllerButton *centerBtn;
@property(nonatomic) UIView *backView;

@end
@implementation TZLMenuButtonView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image heightImage:(UIImage *)heightImage {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        self.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, ([UIScreen mainScreen].bounds.size.height - 64) * 0.5 + 64);
        [self initViewWithImage:image heightImage:heightImage];
    }
    return self;
}

- (void)initViewWithImage:(UIImage *)image heightImage:(UIImage *)heightImage {
    self.centerBtn = [[ControllerButton alloc] initWithImage:image highlightedImage:heightImage];
    self.centerBtn.center = CGPointMake(self.frame.size.width * .5, self.frame.size.height * .5);
    self.centerBtn.delegate = self;
    [self addSubview:self.centerBtn];
    
}

- (void)centerButtonAction {
    static BOOL isBlood = YES;
    if (isBlood) {
        isBlood = NO;
        self.frame = CGRectMake(0, 64, kScreenW, kScreenH - 64);
        self.centerBtn.center = CGPointMake(self.frame.size.width * .5, self.frame.size.height * .5);
        if (!self.backView) {
            self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
            self.backView.center = CGPointMake(self.frame.size.width * .5, self.frame.size.height * .5);
            self.backView.backgroundColor = [UIColor blackColor];
            self.backView.alpha = 0.0f;
            [self insertSubview:self.backView belowSubview:self.centerBtn];
        }
        [UIView animateWithDuration:0.618 * 3 delay:.0 options:UIViewAnimationOptionTransitionNone animations:^{
            self.backView.alpha = 0.3;
        } completion:nil];
        [UIView animateWithDuration:0.618 delay:.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.centerBtn.transform = CGAffineTransformMakeRotation(.75 * M_PI);
        } completion:nil];
        
        CGFloat radius = 100.0f;
        if (self.items && self.items.count > 0) {
            CGFloat basicAngel = 180 / (self.items.count + 1) ;
            for (int i = 0; i < self.items.count; i++) {
                TZLImageView *image = self.items[i];
                image.tag = 1000 + i;
                image.center = CGPointMake(self.frame.size.width * .5, self.frame.size.height * .5);
                [self insertSubview:image belowSubview:self.centerBtn];
                CGFloat currentAngel = basicAngel * (i + 1) / 180;
                CGPoint farPoint = [self createEndPointWithRadius:radius + 10 angle:currentAngel];
                CGPoint nearPoint = [self createEndPointWithRadius:radius - 5 angle:currentAngel];
                CGPoint endPoint = [self createEndPointWithRadius:radius angle:currentAngel];
                CAAnimationGroup *group = [self bloomAnimationWithFarPoint:farPoint nearPoint:nearPoint endPoint:endPoint];
                [image.layer addAnimation:group forKey:@"group"];
                image.center = endPoint;
            }
        }
    } else {
        isBlood = YES;
        [UIView animateWithDuration:0.618 * 3 delay:.0 options:UIViewAnimationOptionTransitionNone animations:^{
            self.backView.alpha = 0;
        } completion:nil];
        [UIView animateWithDuration:0.618 delay:.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.centerBtn.transform = CGAffineTransformMakeRotation(0);
        } completion:nil];
        for (int i = 0; i < self.items.count; i++) {
            TZLImageView *image = [self viewWithTag:1000+i];
            CAAnimationGroup *group = [self foldAnimation];
            [image.layer addAnimation:group forKey:@"groupFold"];
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                image.center = CGPointMake(self.frame.size.width * .5, self.frame.size.height * .5);
            } completion:nil];
        }
        
    }
}

- (CGPoint)createEndPointWithRadius:(CGFloat)radius angle:(CGFloat)angle {
    return CGPointMake(self.frame.size.width * .5 - cosf(angle * M_PI) * radius, self.frame.size.height * .5 - sinf(angle * M_PI) * radius);
}
- (CAAnimationGroup *)bloomAnimationWithFarPoint:(CGPoint)farPoint nearPoint:(CGPoint)nearPoint endPoint:(CGPoint)endPoint {
    CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.values = @[@(0.0), @(-M_PI), @(-M_PI * 1.5), @(-M_PI * 2)];
    rotationAnimation.duration = 1.0f;
    rotationAnimation.keyTimes = @[@(0.0), @(0.3), @(0.6), @(1.0)];
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value = [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width * .5, self.frame.size.height * .5)];
    NSValue *vlaue0 = [NSValue valueWithCGPoint:farPoint];
    NSValue *vlaue1 = [NSValue valueWithCGPoint:nearPoint];
    NSValue *vlaue2 = [NSValue valueWithCGPoint:endPoint];
    positionAnimation.values = @[value, vlaue0, vlaue1, vlaue2];
    positionAnimation.keyTimes = @[@(0.0), @(0.4), @(0.75), @(1.0)];
    positionAnimation.duration = 1.0f;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[positionAnimation, rotationAnimation];
    group.duration = 1;
    return group;
}
- (CAAnimationGroup *)foldAnimation {
    CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.values = @[@(-M_PI * 2), @(-M_PI * 1.5), @(-M_PI), @(0.0)];
    rotationAnimation.duration = .5f;
    rotationAnimation.keyTimes = @[@(0.0), @(0.3), @(0.6), @(1.0)];
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width * .5, self.frame.size.height * .5)];
    positionAnimation.duration = 3;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[rotationAnimation];
    group.duration = .5;
    return group;
}

@end
