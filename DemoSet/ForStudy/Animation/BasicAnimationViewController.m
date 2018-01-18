//
//  BasicAnimationViewController.m
//  DemoSet
//
//  Created by tang on 2017/11/28.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "BasicAnimationViewController.h"

@interface BasicAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *demoView;

@end

@implementation BasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.demoView.bounds = CGRectMake(0, 0, 100, 100);
    self.demoView.center = CGPointMake(200, 200);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)positionAction:(id)sender {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 2.0;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
    animation.autoreverses = YES;
    animation.repeatCount = MAXFLOAT;
    [self.demoView.layer addAnimation:animation forKey:@"demoPostionAnimation"];
}
- (IBAction)transformAction:(id)sender {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 2.0;
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:2.0];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.demoView.layer addAnimation:animation forKey:@"demotransformAnimation"];
}
- (IBAction)transitionAction:(id)sender {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 2.0;
    animation.fromValue=[NSNumber numberWithFloat:0.f];
    animation.toValue=[NSNumber numberWithFloat:M_PI * 2];
    animation.repeatCount = MAXFLOAT;
    [self.demoView.layer addAnimation:animation forKey:@"demorotationAnimation"];
}
- (IBAction)alphaAction:(id)sender {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 2.0;
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:0.2];
    [self.demoView.layer addAnimation:animation forKey:@"demoopacityAnimation"];
}
- (IBAction)backgroundColorAction:(id)sender {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.duration = 2.0;
    animation.toValue = (id)[UIColor blueColor].CGColor;
    [self.demoView.layer addAnimation:animation forKey:@"demobackgroundColorAnimation"];
}



@end
