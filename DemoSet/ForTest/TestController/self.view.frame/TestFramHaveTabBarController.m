//
//  TestFramHaveTabBarController.m
//  DemoSet
//
//  Created by tang on 2018/1/3.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "TestFramHaveTabBarController.h"
#import "TestFramHaveTabBarViewController.h"
@interface TestFramHaveTabBarController ()

@end

@implementation TestFramHaveTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    TestFramHaveTabBarViewController *vc = [TestFramHaveTabBarViewController new];
    TestFramHaveTabBarViewController *vc2 = [TestFramHaveTabBarViewController new];
    UIImage *image = [[UIImage imageNamed:@"动态点击后"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem = [vc.tabBarItem initWithTitle:@"试试" image:image selectedImage:image];
    vc2.tabBarItem = [vc2.tabBarItem initWithTitle:@"试试2" image:image selectedImage:image];
    [self addChildViewController:vc];
    [self addChildViewController:vc2];
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
