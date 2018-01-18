//
//  OverBorderViewController.m
//  DemoSet
//
//  Created by tang on 2017/12/6.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "OverBorderViewController.h"

@interface OverBorderViewController ()

@end

@implementation OverBorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *array = @[@1, @"第三方", @"sdf", @(5)];
    id tmp = [array objectAtIndex:4];
    NSLog(@"%@", tmp);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
