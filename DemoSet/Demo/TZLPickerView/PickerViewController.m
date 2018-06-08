//
//  PickerViewController.m
//  DemoSet
//
//  Created by tang on 2018/6/6.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "PickerViewController.h"
#import "TZLPickerViewController.h"

@interface PickerViewController () {
    UILabel *label;
}

@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"pick" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addBtn.frame = CGRectMake(50, 100, 100, 50);
    [addBtn addTarget:self action:@selector(pickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    label = [UILabel new];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
    }];
}
- (void)pickAction {
    TZLPickerViewController *pickerVC = [TZLPickerViewController new];
    pickerVC.pickerType = PickerViewDateType;
    pickerVC.defaultDate = @"2019-11-29";
    NSArray *tmp = @[@"1", @"2", @"3", @"4",
                     @"5", @"6", @"7", @"8",
                     @"9", @"10", @"11", @"12"];
    pickerVC.customArr = tmp;
    [self presentViewController:pickerVC animated:YES completion:nil];
    pickerVC.dateBlock = ^(TZLPickerDataModel *model) {
        label.text = model.pickerText;
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
