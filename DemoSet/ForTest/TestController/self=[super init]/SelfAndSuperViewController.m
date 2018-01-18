//
//  SelfAndSuperViewController.m
//  DemoSet
//
//  Created by tang on 2017/12/27.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "SelfAndSuperViewController.h"

@interface SelfAndSuperViewController ()
@property(nonatomic, strong) NSString *mTest;
@end

@implementation SelfAndSuperViewController

- (instancetype)initWithTest:(NSString *)test {
    /* 打印出来的self 都是 <SubSelfAndSuperViewController: 0x7fe114d15920>  跟子类的self 内存地址是一样的  */
    if (self = [super init]) {
        self.test = test;
        self.mTest = test;
        NSLog(@"%s, %@, %@, %@", __func__, self, self.test, self.mTest);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
