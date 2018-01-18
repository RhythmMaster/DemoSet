//
//  AutoLayoutBaseViewController.m
//  DemoSet
//
//  Created by tang on 2018/1/10.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "AutoLayoutBaseViewController.h"
#import "OtherAutoLayoutViewController.h"
#import "TZLTextView.h"

@interface AutoLayoutBaseViewController () <UITextViewDelegate> {
    UILabel *_testLbale;
}

@end

@implementation AutoLayoutBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createLabelWithAutoLayout];
}

- (void)createLabelWithAutoLayout {
    _testLbale = ({
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor orangeColor];
        label.numberOfLines = 0;
        label;
    });
    [self.view addSubview:_testLbale];
    /*
     只是设置了label的坐标  根据:
     Auto Layout System在layout时，不知道该为view分配多大的size，因此回调view的intrinsicContentSize方法，该方法会给auto layout system一个合适的size，system根据此size对view的大小进行设置；
     Auto Layout System 会自动算出label的size  在下面的  viewDidAppear:(BOOL)animated  这个方法中就可以看到
     
     注意: intrinsicContentSize  只能使用与有内容的view  比如 UILabel  UIButton  UIImageview 等
     例如 UIview 是不行的  没有具体内容  其中 UITextView也是不行的  他是继承自UIScrollview的  也不行 但可以通过 sizeThatFits 得到size 看下面的UITextView相关的测试
     */
    [_testLbale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(40 + 64);
        make.left.equalTo(10);
    }];
    _testLbale.text = @"天地玄黄 宇宙洪荒 日月盈昃 辰宿列张";
    
    UIButton *modifyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:modifyBtn];
    [modifyBtn setTitle:@"修改(preferredMaxLayoutWidth)属性" forState:UIControlStateNormal];
    [modifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_testLbale.mas_left);
        make.top.equalTo(_testLbale.mas_bottom).equalTo(10);
    }];
    [modifyBtn addTarget:self action:@selector(modifyAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:nextBtn];
    [nextBtn setTitle:@"下一种(重点)" forState:UIControlStateNormal];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(modifyBtn.mas_left);
        make.top.equalTo(modifyBtn.mas_bottom).equalTo(10);
    }];
    [nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    TZLTextView *textView = [TZLTextView new];
//    [self.view addSubview:textView];
//    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(10);
//        make.top.equalTo(modifyBtn.mas_bottom).equalTo(10);
//        make.width.equalTo(self.view.frame.size.width - 20);
//        make.height.equalTo(30);
//    }];
//    textView.layer.borderColor = [UIColor grayColor].CGColor;
//    textView.layer.borderWidth = 1.0;
//    textView.layer.cornerRadius = 5;
//    textView.delegate = self;
//    [textView sizeToFit];
}
- (void)modifyAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    _testLbale.preferredMaxLayoutWidth = _testLbale.frame.size.width / _testLbale.text.length * sender.selected;
}
- (void)nextAction:(UIButton *)sender {
    OtherAutoLayoutViewController *VC = [OtherAutoLayoutViewController new];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark delete UITextView
//- (void)textViewDidChange:(UITextView *)textView {
////    CGSize size = [textView sizeThatFits:CGSizeMake(self.view.frame.size.width - 20, 90)];
////    [textView mas_updateConstraints:^(MASConstraintMaker *make) {
////        make.height.equalTo(size.height);
////    }];
//}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"testLbale.frame.size=%@", NSStringFromCGSize(_testLbale.frame.size));
    NSLog(@"_testLbale.frame.origin=%@", NSStringFromCGPoint(_testLbale.frame.origin));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
