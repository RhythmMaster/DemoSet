//
//  SecondViewController.m
//  DemoSet
//
//  Created by tang on 2017/11/13.
//  Copyright © 2017年 HZ. All rights reserved.
//  这个为了测试   圆形到底是不是通过  layer.masksToBounds设置的

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self  tzl_setLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tzl_setLayer {
    CALayer *layer = [CALayer new];
    layer.bounds = CGRectMake(0, 0, 80, 80);
    layer.position = CGPointMake(200, 200);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    //只设置 cornerRadius  也能形成圆
    CALayer *layer1 = [CALayer new];
    layer1.bounds = CGRectMake(0, 0, 80, 80);
    layer1.position = CGPointMake(200, 300);
    layer1.backgroundColor = [UIColor redColor].CGColor;
    layer1.cornerRadius = 40;
    [self.view.layer addSublayer:layer1];
}

@end
