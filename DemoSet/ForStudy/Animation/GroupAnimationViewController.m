//
//  GroupAnimationViewController.m
//  DemoSet
//
//  Created by tang on 2017/11/28.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "GroupAnimationViewController.h"

@interface GroupAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *demoView;

@end

@implementation GroupAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.demoView.bounds = CGRectMake(0, 0, 100, 100);
    self.demoView.center = CGPointMake(200, 200);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//同时
- (IBAction)asyncAction:(id)sender {
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(150, 300)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(250, 300)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(300, 200)];
    positionAnimation.values = @[value, value0, value1, value2, value3];
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue = [NSNumber numberWithFloat:2.0];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 4];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[positionAnimation, scaleAnimation, rotationAnimation];
    group.duration = 4;
    
    [self.demoView.layer addAnimation:group forKey:@"grounAnimation"];
    
}
//连续
- (IBAction)syncAnimation:(id)sender {
    CFTimeInterval currentTime = CACurrentMediaTime();
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(150, 300)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(250, 300)];
    positionAnimation.values = @[value, value0, value1, value2];
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    positionAnimation.beginTime = currentTime;
    positionAnimation.duration = 3;
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.removedOnCompletion = NO;
    [self.demoView.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue = [NSNumber numberWithFloat:2.0];
    scaleAnimation.beginTime = currentTime + 3;
    scaleAnimation.duration = 1;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    [self.demoView.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 4];
    rotationAnimation.beginTime = currentTime + 3 + 1;
    rotationAnimation.duration = 2;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [self.demoView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}



@end
