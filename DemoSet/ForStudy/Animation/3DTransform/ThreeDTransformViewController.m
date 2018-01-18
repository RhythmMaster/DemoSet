//
//  ThreeDTransformViewController.m
//  DemoSet
//
//  Created by tang on 2017/12/7.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "ThreeDTransformViewController.h"
#import "ThreeDTransitionAnimationViewController.h"
#import "SublayerTransformViewController.h"
#import "DoubleSidedViewController.h"
#import "SolidObjectViewController.h"

@interface ThreeDTransformViewController ()

@end

@implementation ThreeDTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)dataArr {
    return @[@"m34的作用", @"sublayerTransform的作用", @"doubleSided的作用", @"固对象"];
}
- (NSArray *)controllerArr {
    return @[[ThreeDTransitionAnimationViewController class], [SublayerTransformViewController class], [DoubleSidedViewController class], [SolidObjectViewController class]];
}

@end
