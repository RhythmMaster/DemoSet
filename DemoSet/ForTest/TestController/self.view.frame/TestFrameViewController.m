//
//  TestFrameViewController.m
//  DemoSet
//
//  Created by tang on 2018/1/3.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "TestFrameViewController.h"
#import "TestFrameTabBarController.h"
#import "TestFramHaveTabBarController.h"

@interface TestFrameViewController ()
@property(nonatomic, strong) UILabel *tmpLb;
@property(nonatomic, strong) UILabel *bottomLb;
@end

@implementation TestFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    /* self.view.frame 的height跟mainScreen是一样的不会因为其他属性改变
     如果透明 起始坐标在左上角 正好占据整个屏幕
     如果不透明 起始坐标在 navigationBar下方开始  超出屏幕 navigationBar的高度
     */
    NSLog(@"%f, %f, %f, %f, [UIScreen mainScreen].bounds.size.height: %f", self.view.frame.size.width, self.view.frame.size.height, self.view.frame.origin.x, self.view.frame.origin.y, [UIScreen mainScreen].bounds.size.height);
    UILabel *tmpLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    tmpLb.backgroundColor = [UIColor redColor];
    [self.view addSubview:tmpLb];
    self.tmpLb = tmpLb;
    
    UILabel *bottomLb = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 70, self.view.frame.size.width, 70)];
    bottomLb.backgroundColor = [UIColor redColor];
    [self.view addSubview:bottomLb];
    self.bottomLb = bottomLb;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 200, 180, 50);
    [button setTitle:@"切换navigationBar透明" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *onlyTabbarButton = [UIButton buttonWithType:UIButtonTypeSystem];
    onlyTabbarButton.frame = CGRectMake(100, 270, 180, 50);
    [onlyTabbarButton setTitle:@"只有tabbar的时候" forState:UIControlStateNormal];
    [onlyTabbarButton addTarget:self action:@selector(buttonTabAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:onlyTabbarButton];
    
    UIButton *TabbarButton = [UIButton buttonWithType:UIButtonTypeSystem];
    TabbarButton.frame = CGRectMake(100, 330, 180, 50);
    [TabbarButton setTitle:@"有tabbar的时候" forState:UIControlStateNormal];
    [TabbarButton addTarget:self action:@selector(tbuttonTabAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TabbarButton];
}

- (void)buttonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.navigationController.navigationBar setTranslucent:sender.selected];
    NSLog(@"%f, %f, %f, %f, [UIScreen mainScreen].bounds.size.height: %f", self.view.frame.size.width, self.view.frame.size.height, self.view.frame.origin.x, self.view.frame.origin.y, [UIScreen mainScreen].bounds.size.height);
    NSLog(@"%f, %f, %f, %f", self.tmpLb.frame.size.width, self.tmpLb.frame.size.height, self.tmpLb.frame.origin.x, self.tmpLb.frame.origin.y);
    NSLog(@"%f, %f, %f, %f", self.bottomLb.frame.size.width, self.bottomLb.frame.size.height, self.bottomLb.frame.origin.x, self.bottomLb.frame.origin.y);
}
- (void)buttonTabAction:(UIButton *)sender {
    TestFrameTabBarController *vc = [[TestFrameTabBarController alloc] initWithIndex:0];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)tbuttonTabAction:(UIButton *)sender {
    TestFramHaveTabBarController *vc = [TestFramHaveTabBarController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTranslucent:YES];
}

@end
