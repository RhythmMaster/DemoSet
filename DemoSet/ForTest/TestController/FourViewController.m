//
//  FourViewController.m
//  DemoSet
//
//  Created by tang on 2017/12/5.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "FourViewController.h"
#import <objc/runtime.h>

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    BOOL success = class_addMethod([self class], @selector(viewWillAppear:), method_getImplementation(class_getInstanceMethod([self class], @selector(tzl_viewWillAppear:))), method_getTypeEncoding(class_getInstanceMethod([self class], @selector(tzl_viewWillAppear:))));
    NSLog(@"替换未实现的方法: %d", success);
    BOOL failure = class_addMethod([self class], @selector(viewDidAppear:), method_getImplementation(class_getInstanceMethod([self class], @selector(tzl_viewDidAppear:))), method_getTypeEncoding(class_getInstanceMethod([self class], @selector(tzl_viewDidAppear:))));
    NSLog(@"替换已实现的方法: %d", failure);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tzl_viewWillAppear:(BOOL)animated {
    NSLog(@"%s", __func__);
}
- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"%s", __func__);
}
- (void)tzl_viewDidAppear:(BOOL)animated {
    NSLog(@"%s", __func__);
}

@end
