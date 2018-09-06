//
//  SubThenAnimationViewController.m
//  DemoSet
//
//  Created by tang on 2018/6/14.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "SubThenAnimationViewController.h"

@interface SubThenAnimationViewController ()
/** 不同动画类型 */
@property(nonatomic, assign) NSInteger animationType;
/** 测试用的动画 */
@property(nonatomic, strong) UIView *testView;
@end

@implementation SubThenAnimationViewController

- (instancetype)initWithAnimationType:(NSInteger)animationType {
    if (self = [super init]) {
        self.animationType = animationType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self testView];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    
    [self normalAnimationWithPoint:point];
}

/**
 *  普通动画实现方式
 *  param
 */
- (void)normalAnimationWithPoint:(CGPoint)point {
    [UIView beginAnimations:@"testAnimation" context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView setAnimationDelegate:self];
    //设置动画将开始时代理对象执行的SEL
    [UIView setAnimationWillStartSelector:@selector(animationDoing)];
    [UIView setAnimationDidStopSelector:@selector(animationDone)];
    //设置动画延迟执行的时间
    [UIView setAnimationDelay:0];
    
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    //设置动画是否继续执行相反的动画
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.testView cache:YES];
    //设置是否从当前状态开始播放动画
    /*假设上一个动画正在播放，且尚未播放完毕，我们将要进行一个新的动画：
     当为YES时：动画将从上一个动画所在的状态开始播放
     当为NO时：动画将从上一个动画所指定的最终状态开始播放（此时上一个动画马上结束）*/
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.testView.center = point;
    self.testView.transform = CGAffineTransformMakeScale(2.5, 2.5);
    self.testView.transform = CGAffineTransformMakeRotation(M_PI);
    
    [UIView commitAnimations];
    
}

/**
 *  动画将要开始时执行的方法
 */
- (void)animationDoing {
    NSLog(@"我看看是不是开始");
    NSLog(@"%@", NSStringFromCGRect(self.testView.frame));
}
/**
 *  动画结束执行方法
 */
- (void)animationDone {
    NSLog(@"我看看是不是结束");
    NSLog(@"%@", NSStringFromCGRect(self.testView.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark lazy
- (UIView *)testView {
    if (!_testView) {
        _testView = [[UIView alloc] init];
        [self.view addSubview:_testView];
        [_testView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(80);
            make.left.equalTo(0);
            make.size.equalTo(CGSizeMake(160, 80));
        }];
        _testView.backgroundColor = [UIColor redColor];
        
        UILabel *label = [UILabel new];
        [_testView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(8);
        }];
        label.text = @"左边";
        label.textColor = [UIColor whiteColor];
    }
    return _testView;
}
@end
