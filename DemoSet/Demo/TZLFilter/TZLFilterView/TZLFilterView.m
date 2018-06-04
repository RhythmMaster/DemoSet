//
//  TZLFilterView.m
//  DemoSet
//
//  Created by tang on 2018/6/4.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "TZLFilterView.h"

@interface TZLFilterView()
/**  */
@property(nonatomic, strong) UIView *backView;
@end

@implementation TZLFilterView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self filerBtn];
    }
    return self;
}
- (void)filterAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    CGRect backViewFrame = self.backView.frame;
    //如果是展示 先设置约束 再做动画
    if (sender.selected) {//展示
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.superview.frame.size.height - self.frame.origin.y);
        }];
        [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.height.equalTo(backViewFrame.size.height);
        }];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3 * sender.selected];
    } completion:^(BOOL finished) {
        //如果是收缩 先动画 再约束
        if (!sender.selected) {//收缩
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(backViewFrame.size.height);
            }];
            [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.equalTo(0);
                make.height.equalTo(backViewFrame.size.height);
            }];
        }
    }];
}

#pragma  mark lazy
- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        [self addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
- (UIButton *)filerBtn {
    if (!_filerBtn) {
        _filerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backView addSubview:_filerBtn];
        [_filerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.centerX.equalTo(-kScreenW * 0.25);
        }];
        [_filerBtn setTitle:@"过滤" forState:UIControlStateNormal];
        [_filerBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _filerBtn.titleLabel.font = [UIFont systemFontOfSize:14.5];
        [_filerBtn addTarget:self action:@selector(filterAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _filerBtn;
}

@end
