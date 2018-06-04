//
//  OtherAutoLayoutViewController.m
//  DemoSet
//
//  Created by tang on 2018/1/11.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "OtherAutoLayoutViewController.h"

@interface OtherAutoLayoutViewController () <UITextViewDelegate> {
    UIView *_bgView;
    UILabel *_testLabel1;
    UILabel *_testLabel2;
    
    UIView *_bgView1;
    UILabel *_testLabel3;
    UITextView *_testView;
}

@end

@implementation OtherAutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

/*
 UILabel  根据 intrinsicContentSize算出了各自的size  约束好各自  那么view的size也可以自动调整
 也就是说  我并没有对view的高度 做约束 但是  auto layout system 能自己算出最佳的高度  具体看下面 viewDidAppear:(BOOL)animated
 */
- (void)createUI {
    _bgView = ({
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(64 + 40);
        }];
        view;
    });
    _testLabel1 = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor orangeColor];
        label.numberOfLines = 0;
        label.preferredMaxLayoutWidth = self.view.frame.size.width - 20;
        [_bgView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.right.lessThanOrEqualTo(-10);
            make.top.equalTo(10);
        }];
        label.text = @"我并没有设置背景view 也就是灰色view的高度 bgView是可以自己适配高度的 我并没有设置背景view 也就是灰色view的高度 bgView是可以自己适配高度的";
        label;
    });
    _testLabel2 = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor orangeColor];
        label.numberOfLines = 0;
        label.preferredMaxLayoutWidth = self.view.frame.size.width - 20;
        [_bgView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.right.lessThanOrEqualTo(-10);
            make.top.equalTo(_testLabel1.mas_bottom).equalTo(10);
            make.bottom.equalTo(-10);
        }];
        label.text = @"我并没有设置背景view 也就是灰色view的高度 bgView是可以自己适配高度的 我并没有设置背景view 也就是灰色view的高度 bgView是可以自己适配高度的 我并没有设置背景view 也就是灰色view的高度 bgView是可以自己适配高度的";
        label;
    });
    
    
    _bgView1 = ({
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(_bgView.mas_bottom).equalTo(20);
        }];
        view;
    });
    _testLabel3 = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor orangeColor];
        label.numberOfLines = 0;
        label.preferredMaxLayoutWidth = self.view.frame.size.width - 20;
        [_bgView1 addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.right.lessThanOrEqualTo(-10);
            make.top.equalTo(10);
        }];
        label.text = @"这个label的下面还有一个UITextView 但是由于没有设置他的size 导致没有显示出来 因为intrinsicContentSize 返回值是 {-1, -1} ";
        label;
    });
    _testView = ({
        UITextView *textView = [UITextView new];
        textView.font = [UIFont systemFontOfSize:18.0];
        textView.textColor = [UIColor whiteColor];
        textView.backgroundColor = [UIColor redColor];
        [_bgView1 addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_testLabel3.mas_left);
            make.right.equalTo(-10);
            make.top.equalTo(_testLabel3.mas_bottom).offset(10);
            make.bottom.equalTo(-10);
        }];
        textView.delegate = self;
        textView.text = @"这个textView没有设置size 但是通过 sizeThatFits 返回值 来适配了";
        textView;
    });
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGSize textViewSize = [_testView sizeThatFits:CGSizeMake(self.view.frame.size.width-20, 0)];
    [_testView mas_updateConstraints:^(MASConstraintMaker *make) {
        //make.width.equalTo(textViewSize.width);
        make.height.equalTo(textViewSize.height);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    /*
     auto layout system在处理某个view的size时，参考值包括：
     自身的intrinsicContentSize方法返回值；UIView 这时候返回的是(-1, -1)
     subviews的intrinsicContentSize方法返回值；
     自身和subviews的constraints；
     
     结论:
     auto layout system是这样计算一下bgView的size的：
     width=max{10+size1.width+10, 10+size2.width+10, size3.width}
     height=max{10+size1.height+10+size2.height+10, size3.height}
     
     */
    SeparatorLineLog;
    CGSize size1 = [_testLabel1 intrinsicContentSize];
    CGSize size2 = [_testLabel2 intrinsicContentSize];
    CGSize size3 = [_bgView intrinsicContentSize];
    NSLog(@"size1 = %@", NSStringFromCGSize(size1));
    NSLog(@"size2 = %@", NSStringFromCGSize(size2));
    NSLog(@"size3 = %@", NSStringFromCGSize(size3));
    
    CGSize bgSize = _bgView.frame.size;
    NSLog(@"bgSize = %@", NSStringFromCGSize(bgSize));
}
#pragma mark delete UITextView
- (void)textViewDidChange:(UITextView *)textView {
    CGSize textViewSize = [_testView sizeThatFits:CGSizeMake(self.view.frame.size.width-20, 0)];
    if (textViewSize.height < 211) {
        [_testView mas_updateConstraints:^(MASConstraintMaker *make) {
            //make.width.equalTo(textViewSize.width);
            make.height.equalTo(textViewSize.height);
        }];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
