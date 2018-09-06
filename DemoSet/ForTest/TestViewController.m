//
//  TestViewController.m
//  DemoSet
//
//  Created by tang on 2017/11/10.
//  Copyright © 2017年 HZ. All rights reserved.
//   

#import "TestViewController.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "SubSelfAndSuperViewController.h"
#import "CategoryFunctionViewController.h"
#import "TestFrameViewController.h"
#import "UILabelNullViewController.h"

#import "UIViewController+TZLExtension.h"

@interface TestViewController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic, copy) NSArray *dataArr;
@property(nonatomic, copy) NSArray *controllerArr;

/** <#注释#> */
@property(nonatomic, strong) UIView *headView;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"功能测试";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height)
                                                 style:(UITableViewStylePlain)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationController setToolbarHidden:YES animated:animated];
    
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.tzl_navigationBarBackgroundAlpha = 0.0;
    
    self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    //去掉自带分割线
    //[_tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIView *headView = [UIView new];
    headView.frame = CGRectMake(0, -164, kScreenW, 164);
    //headView.backgroundColor = [UIColor redColor];
    UIImageView *headImageView = [UIImageView new];
    headImageView.image = [UIImage imageNamed:@"未命名"];
    //headImageView.frame = headView.frame;
    [headView addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    [self.tableView addSubview:headView];
    self.headView = headView;
    NSLog(@"self.headView.frame: %@", NSStringFromCGRect(self.headView.frame));
    
    [self.tableView addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionNew context:nil];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSValue *newValue = change[NSKeyValueChangeNewKey];
    CGPoint contentOffset = newValue.CGPointValue;
    [self updateOriginWithOffset:contentOffset];
}
- (void)dealloc {
    [self.tableView removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset))];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)updateOriginWithOffset:(CGPoint)offset {
    CGFloat offSet_Y = offset.y;
    NSLog(@"scrollView.contentOffset: %@", NSStringFromCGPoint(offset));
    CGRect frame = self.headView.frame;
    frame.origin.y = offSet_Y;
    frame.size.height = -offSet_Y;
    if (offSet_Y >= -128 && offSet_Y <= -64) {
        CGFloat alpha = (offSet_Y + 128) / 64;
        self.tzl_navigationBarBackgroundAlpha = alpha;
    }
    if (offSet_Y >= -64) {
        self.tzl_navigationBarBackgroundAlpha = 1.0f;//确保拉的过快的情况
    }
    if (offSet_Y < -128) {
        self.tzl_navigationBarBackgroundAlpha = 0;//确保拉的过快的情况
    }
    if (offSet_Y < -228) {
        frame.size.width = kScreenW + (-offSet_Y - 228);
    }
    self.headView.frame = frame;
    NSLog(@"self.headView.frame: %@", NSStringFromCGRect(self.headView.frame));
    NSLog(@"%s", __func__);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //FIXME:重点说明:  利用观察者模式 比在这里要更加精确 ,不会出现视图更新跟不上的情况 比如上滑过快导致 顶部瞬间出现的空白情况
    //[self updateOriginWithOffset:scrollView.contentOffset];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.3 animations:^{
        self.headView.frame = CGRectMake(0, -164, kScreenW, 164);
    }];
    
    NSLog(@"%s", __func__);
}


#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 立即取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    
    if (row >= 8) {
//        UIView *naviBackView = [self.navigationController.navigationBar valueForKey:@"_backgroundView"];
//        naviBackView.backgroundColor = [UIColor redColor];
//        naviBackView.alpha = 1.0;
    } else {
        UIViewController *VC = [self.controllerArr[indexPath.row] new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
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
        _dataArr = @[@"旋转动画测试", @"layer.masksToBounds测试", @"CALayer绘图", @"class_addMethod返回值问题", @"self = [super init]", @"分类跟原类方法问题", @"self.view.frame问题", @"利用Runtime解决label.text=null为题", @"点一下改变导航栏", @"凑凑", @"凑凑", @"凑凑", @"凑凑", @"凑凑", @"凑凑", @"凑凑", @"凑凑", @"凑凑", @"凑凑", @"凑凑", @"凑凑", @"凑凑", @"凑凑", @"凑凑", @"凑凑", @"凑凑", @"凑凑", @"凑凑", @"凑凑"];
    }
    return _dataArr;
}
- (NSArray *)controllerArr {
    if (!_controllerArr) {
        _controllerArr = @[[FirstViewController class], [SecondViewController class], [ThirdViewController class], [FourViewController class], [SubSelfAndSuperViewController class], [CategoryFunctionViewController class], [TestFrameViewController class], [UILabelNullViewController class]];
        
    }
    return _controllerArr;
}

@end
