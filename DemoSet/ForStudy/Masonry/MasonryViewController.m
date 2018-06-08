//
//  MasonryViewController.m
//  DemoSet
//
//  Created by tang on 2018/6/5.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "MasonryViewController.h"
#import "SubMasonaryViewController.h"

@interface MasonryViewController ()

@end

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArr = @[@"[初级] 让两个高度为150的view垂直居中且等宽且等间隔排列 间隔为10(自动计算其宽度)",
                     @"[中级] 在UIScrollView顺序排列一些view并自动计算contentSize",
                     @"Masonry确定间距等间距布局",
                     @"Masonry确定每个item长度等间距布局"];
    WK(weakSelf);
    self.didSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
        SubMasonaryViewController *subVC = [[SubMasonaryViewController alloc] initWithValue:indexPath.row];
        [weakSelf.navigationController pushViewController:subVC animated:YES];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
