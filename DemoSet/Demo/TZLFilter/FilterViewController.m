//
//  FilterViewController.m
//  DemoSet
//
//  Created by tang on 2018/6/4.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "FilterViewController.h"
#import "TZLFilterView.h"

@interface FilterViewController () <TZLFilterViewDelegate>
/** 过滤view */
@property(nonatomic, strong) TZLFilterView *filterView;
/** columns titles */
@property(nonatomic, strong) NSArray *columnsTitles;
/** rows titles */
@property(nonatomic, strong) NSArray *rowsTitles;
/** twoRows titles */
@property(nonatomic, strong) NSArray *twoRowsTitles;
@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArr = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8",
                     @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18"];
    
    self.columnsTitles = @[@"金额升序", @"金额降序", @"日期升序", @"日期降序"];
    self.rowsTitles = @[@"111", @"222", @"333", @"444", @"555"];
    self.twoRowsTitles = @[@"3--111 + 3", @"3--222 + 3", @"3--333 + 3", @"3--444 + 3", @"3--555 + 3", @"3--666 + 3"];
    
    [self filterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delete TZLFilterViewDelegate
- (NSInteger)numberOfColumnsInMenuView:(TZLFilterMenu *)menuView {
    if (menuView.index != 0) {
        return 1;
    }
    return 3;
}
- (NSInteger)menuView:(TZLFilterMenu *)menuView numberOfRowInColumns:(NSInteger)columns {
    if (menuView.index != 0) {
        return self.columnsTitles.count;
    } else {
        if (columns == 0) {
            return self.columnsTitles.count;
        }
        if (columns == 2) {
            return self.twoRowsTitles.count;
        }
        return self.rowsTitles.count;
    }
}
- (NSString *)menuView:(TZLFilterMenu *)menuView titleOfRowInColumns:(NSInteger)columns row:(NSInteger)row {
    if (menuView.index != 0) {
        return self.columnsTitles[row];
    } else {
        if (columns == 0) {
            return self.columnsTitles[row];
        }
        if (columns == 2) {
            return self.twoRowsTitles[row];
        }
        return self.rowsTitles[row];
    }
}
- (void)menuView:(TZLFilterMenu *)menuView didSelectedWithColumns:(NSInteger)columns row:(NSInteger)row {
    if (menuView.index != 0) {
        NSLog(@"你居然能点到第二个menu");
    } else {
        if (columns == 0) {
            if (row == 0) {
                self.rowsTitles = @[@"111", @"222", @"333", @"444", @"555"];
            }
            if (row == 1) {
                self.rowsTitles = @[@"111 + 1", @"222 + 1", @"333 + 1", @"444 + 1", @"555 + 1", @"666 + 1"];
            }
            if (row == 2) {
                self.rowsTitles = @[@"111 + 2", @"222 + 2", @"333 + 2", @"444 + 2", @"555 + 2", @"666 + 2"];
            }
            if (row == 3) {
                self.rowsTitles = @[@"111 + 3", @"222 + 3", @"333 + 3", @"444 + 3", @"555 + 3", @"666 + 3"];
            }
            //        [self.filterView reloadDataWithColumns:columns + 1];
        } else if (columns == 1) {
            if (row == 0) {
                self.twoRowsTitles = @[@"3--111 + 1", @"3--222 + 2", @"3--333 + 3", @"3--444 + 4", @"3--555 + 5", @"3--666 + 6"];
            }
            if (row == 1) {
                self.twoRowsTitles = @[@"3--111 + 1 + 1", @"3--222 + 2 + 1", @"3--333 + 3 + 1", @"3--444 + 1", @"3--555 + 5 + 1", @"3--666 + 6 + 1"];
            }
            if (row == 2) {
                self.twoRowsTitles = @[@"3--111 + 1 + 2", @"3--222 + 2 + 2", @"3--333 + 3 + 2", @"3--444 + 4 + 2", @"3--555 + 5 + 2", @"3--666 + 6 + 2"];
            }
            if (row == 3) {
                self.twoRowsTitles = @[@"3--111 + 1 + 3", @"3--222 + 2 + 3", @"3--333 + 3 + 3", @"3--444 + 4 + 3", @"3--555 + 5 + 3", @"3--666 + 6 + 3"];
            }
        } else {
            
            NSLog(@"来来来,你想干嘛");
        }
    }
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
        _filterView.selectedColor = [UIColor redColor];
        _filterView.TZLFilterViewDelegate = self;
        _filterView.titles = @[@"全部", @"综合排序"];
        self.tableViewFrame = CGRectMake(0, 36, kScreenW, kScreenH - 36);
    }
    return _filterView;
}

@end
