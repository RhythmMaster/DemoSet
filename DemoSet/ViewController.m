//
//  ViewController.m
//  DemoSet
//
//  Created by tang on 2017/11/8.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "ViewController.h"
#import "RefreshDemoViewController.h"
#import "DownloadViewController.h"
#import "TestViewController.h"
#import "ForStudyViewController.h"



@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic, copy) NSArray *dataArr;
@property(nonatomic, copy) NSArray *controllerArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height)
                                                 style:(UITableViewStylePlain)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    //去掉自带分割线
    //[_tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 立即取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *VC = [self.controllerArr[indexPath.row] new];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@"下拉刷新", @"异步下载", @"功能测试", @"学习"];
    }
    return _dataArr;
}
- (NSArray *)controllerArr {
    if (!_controllerArr) {
        _controllerArr = @[[RefreshDemoViewController class], [DownloadViewController class], [TestViewController class], [ForStudyViewController class]];
    }
    return _controllerArr;
}

@end
