//
//  TestFrameTabBarController.m
//  DemoSet
//
//  Created by tang on 2018/1/3.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "TestFrameTabBarController.h"
#import "TestFramOnlyTabBarViewController.h"
#import "TestFramHaveTabBarViewController.h"

@interface TestFrameTabBarController ()
@property(nonatomic, assign) NSInteger index;
@end

@implementation TestFrameTabBarController
- (instancetype)initWithIndex:(NSInteger)index {
    if (self = [super init]) {
        self.index = index;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    TestFramOnlyTabBarViewController *vc = [TestFramOnlyTabBarViewController new];
    TestFramOnlyTabBarViewController *vc2 = [TestFramOnlyTabBarViewController new];
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



@end
