//
//  FilterViewController.m
//  DemoSet
//
//  Created by tang on 2018/6/4.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "FilterViewController.h"
#import "TZLFilterView.h"

@interface FilterViewController ()
/** 过滤view */
@property(nonatomic, strong) TZLFilterView *filterView;
@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArr = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8",
                     @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18"];
    
    [self filterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark lazy
- (TZLFilterView *)filterView {
    if (!_filterView) {
        _filterView = [TZLFilterView new];
        [self.view addSubview:_filterView];
        [self.view bringSubviewToFront:_filterView];
        [_filterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(kNavAndStatusHight);
            make.left.right.equalTo(0);
            make.height.equalTo(36);
        }];
        self.tableViewFrame = CGRectMake(0, 36, kScreenW, kScreenH - 36);
    }
    return _filterView;
}

@end
