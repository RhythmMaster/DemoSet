//
//  TestFramOnlyTabBarViewController.m
//  DemoSet
//
//  Created by tang on 2018/1/3.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "TestFramOnlyTabBarViewController.h"

@interface TestFramOnlyTabBarViewController ()

@end

@implementation TestFramOnlyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tabBarController.tabBar setTranslucent:NO];
    
    NSLog(@"%f, %f, %f, %f, [UIScreen mainScreen].bounds.size.height: %f", self.view.frame.size.width, self.view.frame.size.height, self.view.frame.origin.x, self.view.frame.origin.y, [UIScreen mainScreen].bounds.size.height);
    UILabel *tmpLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    tmpLb.backgroundColor = [UIColor redColor];
    [self.view addSubview:tmpLb];
    
    UILabel *bottomLb = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 70, self.view.frame.size.width, 70)];
    bottomLb.backgroundColor = [UIColor redColor];
    [self.view addSubview:bottomLb];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(10, 80, 180, 50);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 200, 180, 50);
    [button setTitle:@"切换tabBar透明" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)buttonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.tabBarController.tabBar setTranslucent:sender.selected];
    NSLog(@"%f, %f, %f, %f, [UIScreen mainScreen].bounds.size.height: %f", self.view.frame.size.width, self.view.frame.size.height, self.view.frame.origin.x, self.view.frame.origin.y, [UIScreen mainScreen].bounds.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setTranslucent:YES];
}

@end
