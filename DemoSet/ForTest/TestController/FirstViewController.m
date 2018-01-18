//
//  FirstViewController.m
//  DemoSet
//
//  Created by tang on 2017/11/13.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property(nonatomic, strong) UIView *testView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *testView = [UIView new];
    [self.view addSubview:testView];
    testView.frame = CGRectMake(100, 100, 200, 40);
    testView.backgroundColor = [UIColor redColor];
    self.testView = testView;
    
    UIButton *rotatinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:rotatinBtn];
    rotatinBtn.bounds = CGRectMake(0, 0, 60, 30);
    rotatinBtn.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5);
    [rotatinBtn setTitle:@"旋转" forState:UIControlStateNormal];
    [rotatinBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rotatinBtn addTarget:self action:@selector(rotationAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rotationAction:(UIButton *)sender {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, self.testView.center.x, self.testView.center.y, 1, 0,M_PI * 2, 1);
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.keyTimes = @[@0,@0.25,@0.5,@0.75,@1];
    animation.duration = 3.0;
    animation.autoreverses = NO;
    animation.repeatCount = MAXFLOAT;
    //让动画更平滑   尤其是两段path链接的
    animation.calculationMode = kCAAnimationPaced;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.beginTime = CACurrentMediaTime();
    //animation.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 100)].CGPath;
    animation.path = path;
    CGPathRelease(path);
    [self.testView.layer addAnimation:animation forKey:@"testViewAnimation"];
}


@end
