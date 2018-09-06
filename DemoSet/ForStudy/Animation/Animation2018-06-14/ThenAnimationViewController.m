//
//  ThenAnimationViewController.m
//  DemoSet
//
//  Created by tang on 2018/6/14.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "ThenAnimationViewController.h"
#import "SubThenAnimationViewController.h"

@interface ThenAnimationViewController ()

@end

@implementation ThenAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"普通实现动画的方式"];
    WK(weakSelf);
    self.didSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
        SubThenAnimationViewController *subVC = [[SubThenAnimationViewController alloc] initWithAnimationType:indexPath.row];
        [weakSelf.navigationController pushViewController:subVC animated:YES];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
