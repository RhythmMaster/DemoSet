//
//  TZLFilterView.m
//  DemoSet
//
//  Created by tang on 2018/6/4.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "TZLFilterView.h"

@interface TZLFilterView()<UITableViewDelegate, UITableViewDataSource>
/** 保存顶部的按钮view */
@property(nonatomic, strong) UIView *backView;
/** tableView */
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation TZLFilterView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self filerBtn];
    }
    return self;
}

#pragma mark method action
- (void)filterAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    CGRect backViewFrame = self.backView.frame;
    //如果是展示 先设置约束 再做动画
    if (sender.selected) {//展示
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.datas.count * 35 + 2);
        }];
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
        self.tableView.alpha = sender.selected;
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
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(0.1);
            }];
        }
    }];
}
#pragma mark delete view
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self filterAction:self.filerBtn];
}
#pragma mark delete tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:13.9];
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}
#pragma mark method set
- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self.tableView reloadData];
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
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(self.backView.mas_bottom);
            make.height.equalTo(0.1);
        }];
//        _tableView.hidden = YES;
        _tableView.rowHeight = 35;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0.1)];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}
@end
