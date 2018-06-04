//
//  TZLButtonViewController.m
//  DemoSet
//
//  Created by tang on 2018/5/29.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "TZLButtonViewController.h"

@interface TZLButtonViewController ()
/** button图片和文字位置 */
@property(nonatomic, strong) UIButton *testBtn;


@property(nonatomic, strong) UIButton *imageTopBtn;
@property(nonatomic, strong) UIButton *imageBottomBtn;
@end

@implementation TZLButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self testBtn];
    [self imageTopBtn];
    [self imageBottomBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)testAction:(UIButton *)sender {
    NSLog(@"%@", NSStringFromCGRect(_testBtn.frame));
//    [_testBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//    [_testBtn setImage:[UIImage imageNamed:@"sales_icon"] forState:UIControlStateNormal];
}
- (void)imageTopAction {
    [_testBtn setButtonImageTitleStyle:TZLButtonImageTop padding:6];
}
- (void)imageBottomAction {
    [_testBtn setButtonImageTitleStyle:TZLButtonImageBottom padding:6];
}
- (UIButton *)testBtn {
    if (!_testBtn) {
        _testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_testBtn];
        [_testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
        }];
        [_testBtn setTitle:@"测试frame" forState:UIControlStateNormal];
        [_testBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [_testBtn setImage:[UIImage imageNamed:@"sales_icon"] forState:UIControlStateNormal];
        _testBtn.backgroundColor = [UIColor orangeColor];
        [self.view layoutIfNeeded];
        NSLog(@"%@", NSStringFromCGRect(_testBtn.frame));
        NSLog(@"%@", NSStringFromCGRect(_testBtn.titleLabel.frame));
        NSLog(@"%@", NSStringFromCGRect(_testBtn.imageView.frame));
        [_testBtn setButtonImageTitleStyle:TZLButtonImageRight padding:10];
        [_testBtn addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testBtn;
}
- (UIButton *)imageTopBtn {
    if (!_imageTopBtn) {
        _imageTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_imageTopBtn];
        [_imageTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(-kScreenW * 0.25);
            make.bottom.equalTo(-50);
        }];
        [_imageTopBtn setTitle:@"imageTop" forState:UIControlStateNormal];
        [_imageTopBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        _imageTopBtn.backgroundColor = [UIColor orangeColor];
        [_imageTopBtn addTarget:self action:@selector(imageTopAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageTopBtn;
}
- (UIButton *)imageBottomBtn {
    if (!_imageBottomBtn) {
        _imageBottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_imageBottomBtn];
        [_imageBottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(kScreenW * 0.25);
            make.bottom.equalTo(-50);
        }];
        [_imageBottomBtn setTitle:@"imageBottom" forState:UIControlStateNormal];
        [_imageBottomBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        _imageBottomBtn.backgroundColor = [UIColor orangeColor];
        [_imageBottomBtn addTarget:self action:@selector(imageBottomAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageBottomBtn;
}
@end
