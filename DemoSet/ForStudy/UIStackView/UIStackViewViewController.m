//
//  UIStackViewViewController.m
//  DemoSet
//
//  Created by tang on 2018/6/5.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "UIStackViewViewController.h"
#import "SubStatckViewViewController.h"

@interface UIStackViewViewController ()

@end

@implementation UIStackViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"UIStackView用法", @"通过Label了解StackView的distribution", @"通过Label了解StackView的alignment", @"利用UIStackView的小demo"];
    WK(weakSelf);
    self.didSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
        SubStatckViewViewController *subVC = [[SubStatckViewViewController alloc] initWithValue:indexPath.row];
        [weakSelf.navigationController pushViewController:subVC animated:YES];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
