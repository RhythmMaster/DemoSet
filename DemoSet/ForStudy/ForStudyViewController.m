//
//  ForStudyViewController.m
//  DemoSet
//
//  Created by tang on 2017/11/28.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "ForStudyViewController.h"

#import "AnimationViewController.h"
#import "ArchiveViewController.h"
#import "FilePathViewController.h"
#import "RuntimeViewController.h"
#import "OverBorderViewController.h"
#import "PictureStretchViewController.h"
#import "AutoLayoutBaseViewController.h"
#import "LLDBViewController.h"
#import "KVOTheoryViewController.h"
#import "AboutCollectionViewController.h"
#import "UserNotificationsViewController.h"
#import "MasonryViewController.h"
#import "UIStackViewViewController.h"
#import "ResponderChainViewController.h"
#import "TZLTabBarController.h"

@interface ForStudyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic, copy) NSArray *dataArr;
@property(nonatomic, copy) NSArray *controllerArr;
@end

@implementation ForStudyViewController

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
        _dataArr = @[@"动画学习", @"文件路径", @"解档归档", @"Runtime", @"利用runtime解决数组越界等问题", @"图片拉伸方式", @"深入理解Auto Layout ", @"LLDB调试学习", @"KVO原理", @"自定义CollectionViewFlowLayout", @"消息推送", @"Masonry还不知道的用法2018-06-05", @"UIStackView", @"iOS响应链(Responder Chain)", @"自定义tabbar"];
    }
    return _dataArr;
}
- (NSArray *)controllerArr {
    if (!_controllerArr) {
        _controllerArr = @[[AnimationViewController class], [FilePathViewController class], [ArchiveViewController class], [RuntimeViewController class], [OverBorderViewController class], [PictureStretchViewController class], [AutoLayoutBaseViewController class], [LLDBViewController class], [KVOTheoryViewController class], [AboutCollectionViewController class], [UserNotificationsViewController class], [MasonryViewController class], [UIStackViewViewController class], [ResponderChainViewController class], [TZLTabBarController class]];
        
    }
    return _controllerArr;
}

@end
