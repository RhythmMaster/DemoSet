//
//  KeyAnimationViewController.m
//  DemoSet
//
//  Created by tang on 2017/11/28.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "KeyAnimationViewController.h"

@interface KeyAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *demoView;

@end

@implementation KeyAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.demoView.bounds = CGRectMake(0, 0, 100, 100);
    self.demoView.center = CGPointMake(100, 200);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)keyFrameAction:(id)sender {
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(150, 300)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(250, 300)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(300, 200)];
    keyAnimation.values = @[value, value0, value1, value2, value3];
    keyAnimation.duration = 4;
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.demoView.layer addAnimation:keyAnimation forKey:@"keyFrameAnimation"];
}
- (IBAction)pathAction:(id)sender {
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 100)];
    keyAnimation.path = path.CGPath;
    keyAnimation.duration = 4;
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.demoView.layer addAnimation:keyAnimation forKey:@"pathAnimation"];
    
}
- (IBAction)shakeAction:(id)sender {
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];//只能这样 .x  .y都不行
    NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*4];
    NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*4];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*4];
    keyAnimation.values = @[value1, value2, value3];
    keyAnimation.repeatCount = MAXFLOAT;
    [self.demoView.layer addAnimation:keyAnimation forKey:@"shakeAnimation"];
}



@end
