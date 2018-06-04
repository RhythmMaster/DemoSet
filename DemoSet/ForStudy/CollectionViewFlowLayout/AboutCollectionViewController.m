//
//  AboutCollectionViewController.m
//  DemoSet
//
//  Created by tang on 2018/3/8.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "AboutCollectionViewController.h"

#import "WaterfallCollectionViewController.h"

@interface AboutCollectionViewController ()

@end

@implementation AboutCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)dataArr {
    return @[@"瀑布流"];
}
- (NSArray *)controllerArr {
    return @[[WaterfallCollectionViewController class]];
}

@end
