//
//  AnimationViewController.m
//  DemoSet
//
//  Created by tang on 2017/11/28.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "AnimationViewController.h"

#import "BasicAnimationViewController.h"
#import "KeyAnimationViewController.h"
#import "GroupAnimationViewController.h"
#import "TransitionAnimationViewController.h"
#import "AffineTransformViewController.h"
#import "ComprehensiveViewController.h"
#import "ThreeDTransformViewController.h"
#import "TransitionAnimationViewControllerFirst.h"

@interface AnimationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic, copy) NSArray *dataArr;
@property(nonatomic, copy) NSArray *controllerArr;
@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
        _dataArr = @[@"基础动画", @"帧动画", @"组动画", @"过渡动画", @"仿射动画", @"综合案例", @"3D转换", @"转场动画"];
    }
    return _dataArr;
}
- (NSArray *)controllerArr {
    if (!_controllerArr) {
        _controllerArr = @[[BasicAnimationViewController class], [KeyAnimationViewController class], [GroupAnimationViewController class], [TransitionAnimationViewController class], [AffineTransformViewController class], [ComprehensiveViewController class], [ThreeDTransformViewController class], [TransitionAnimationViewControllerFirst class]];
        
    }
    return _controllerArr;
}

@end
