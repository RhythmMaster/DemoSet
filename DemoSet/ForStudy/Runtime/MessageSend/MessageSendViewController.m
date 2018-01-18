//
//  MessageSendViewController.m
//  DemoSet
//
//  Created by tang on 2017/12/5.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "MessageSendViewController.h"
#import <objc/runtime.h>
#import "AMessageReceiver.h"

@interface MessageSendViewController ()

@end

@implementation MessageSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *buttonA = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonA.frame = CGRectMake(0, 0, 100, 40);
    buttonA.center = CGPointMake(self.view.frame.size.width * .5, 100);
    [buttonA setTitle:@"动态方法解析" forState:UIControlStateNormal];
    [self.view addSubview:buttonA];
    [buttonA addTarget:self action:@selector(buttonActionA:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonB = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonB.frame = CGRectMake(0, 0, 100, 40);
    buttonB.center = CGPointMake(self.view.frame.size.width * .5, 200);
    [buttonB setTitle:@"备用接收者" forState:UIControlStateNormal];
    [self.view addSubview:buttonB];
    [buttonB addTarget:self action:@selector(buttonActionB:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonC = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonC.frame = CGRectMake(0, 0, 100, 40);
    buttonC.center = CGPointMake(self.view.frame.size.width * .5, 300);
    [buttonC setTitle:@"完整消息转发" forState:UIControlStateNormal];
    [self.view addSubview:buttonC];
    [buttonC addTarget:self action:@selector(buttonActionC:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonD = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonD.frame = CGRectMake(0, 0, 100, 40);
    buttonD.center = CGPointMake(self.view.frame.size.width * .5, 400);
    [buttonD setTitle:@"消息没法实现" forState:UIControlStateNormal];
    [self.view addSubview:buttonD];
    [buttonD addTarget:self action:@selector(buttonActionD:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/* 动态方法解析 */
- (void)buttonActionA:(UIButton *)sender {
    AMessageReceiver *A = [AMessageReceiver new];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [A performSelector:@selector(resolveInstanceFunction)];
#pragma clang diagnostic pop
    
}

/* 备用接收者 */
- (void)buttonActionB:(UIButton *)sender {
    AMessageReceiver *A = [AMessageReceiver new];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [A performSelector:@selector(forwardingTargetForSelectorFunction)];
#pragma clang diagnostic pop
    
}

/* 完整消息转发 */
- (void)buttonActionC:(UIButton *)sender {
    AMessageReceiver *A = [AMessageReceiver new];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [A performSelector:@selector(signatureFunction)];
#pragma clang diagnostic pop
    
}

/* 没有实现的消息 */
- (void)buttonActionD:(UIButton *)sender {
    AMessageReceiver *A = [AMessageReceiver new];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [A performSelector:@selector(doesNotRecognize)];
#pragma clang diagnostic pop
    
}

@end
