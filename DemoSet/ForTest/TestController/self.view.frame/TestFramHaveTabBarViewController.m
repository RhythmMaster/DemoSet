//
//  TestFramHaveTabBarViewController.m
//  DemoSet
//
//  Created by tang on 2018/1/3.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "TestFramHaveTabBarViewController.h"

@interface TestFramHaveTabBarViewController ()

@end

@implementation TestFramHaveTabBarViewController

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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 200, 180, 50);
    [button setTitle:@"切换tabBar透明" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *nabutton = [UIButton buttonWithType:UIButtonTypeSystem];
    nabutton.frame = CGRectMake(100, 260, 180, 50);
    [nabutton setTitle:@"切换naviBar透明" forState:UIControlStateNormal];
    [nabutton addTarget:self action:@selector(nabuttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nabutton];
}

- (void)buttonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.tabBarController.tabBar setTranslucent:sender.selected];
    NSLog(@"%f, %f, %f, %f, [UIScreen mainScreen].bounds.size.height: %f", self.view.frame.size.width, self.view.frame.size.height, self.view.frame.origin.x, self.view.frame.origin.y, [UIScreen mainScreen].bounds.size.height);
}
- (void)nabuttonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.navigationController.navigationBar setTranslucent:sender.selected];
    NSLog(@"%f, %f, %f, %f, [UIScreen mainScreen].bounds.size.height: %f", self.view.frame.size.width, self.view.frame.size.height, self.view.frame.origin.x, self.view.frame.origin.y, [UIScreen mainScreen].bounds.size.height);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
