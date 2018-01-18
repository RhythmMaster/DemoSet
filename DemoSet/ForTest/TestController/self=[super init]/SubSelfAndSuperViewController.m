//
//  SubSelfAndSuperViewController.m
//  DemoSet
//
//  Created by tang on 2017/12/27.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "SubSelfAndSuperViewController.h"

@interface SubSelfAndSuperViewController ()

@end

@implementation SubSelfAndSuperViewController

- (instancetype)init {
    /* 打印出来的self 都是 <SubSelfAndSuperViewController: 0x7fe114d15920>  跟父类的self 内存地址是一样的
        所以父类中的self.test属性其实是子类作为接收者的属性  父类并不存在
     */
    if (self = [super initWithTest:@"12344"]) {
        NSLog(@"%s, %@, %@", __func__, self, self.test);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
