//
//  UILabelNullViewController.m
//  DemoSet
//
//  Created by tang on 2018/2/2.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "UILabelNullViewController.h"

@interface UILabelNullViewController ()

@end

@implementation UILabelNullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
    }];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor redColor];
    NSString *string;
    NSString *testStr = [NSString stringWithFormat:@"%@这不是空值呢", string ?: @""];
    if ([testStr isEqualToString:@"(null)"]) {
        NSLog(@"我曹,这是个大坑啊");
    }
    //label.text = [NSString stringWithFormat:@"%@", string] ?: @"";
    label.text = testStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
