//
//  DemoViewController.m
//  DemoSet
//
//  Created by tang on 2018/5/29.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "DemoViewController.h"
#import "TZLButtonViewController.h"
#import "FilterViewController.h"
#import "PickerViewController.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"UIButton位置调整", @"过滤的View", @"PickerView"];
    self.controllerArr = @[[TZLButtonViewController class], [FilterViewController class],
                           [PickerViewController class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
