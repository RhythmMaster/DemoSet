//
//  TZLFilterView.m
//  DemoSet
//
//  Created by tang on 2018/6/4.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "TZLFilterView.h"
//FIXME:筛选的按钮View
@interface TZLFilterMenu()
/**  */
@property(nonatomic, strong) CAShapeLayer *indicator;
@end
@implementation TZLFilterMenu
- (instancetype)init {
    if (self = [super init]) {
        [self addTapGestureRecognizer];
        
        UIView *lineView = [UIView new];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(5).priorityLow();
            make.right.equalTo(0);
            make.bottom.equalTo(-5).priorityLow();
            make.width.equalTo(1);
        }];
        lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self createIndicatorWithColor:[UIColor grayColor] andPosition:CGPointMake(self.titleLb.frame.origin.x + self.titleLb.frame.size.width + 8, self.titleLb.frame.origin.y + self.titleLb.frame.size.height * 0.5)];
}
- (void)createIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point {
    CGPathRef bound = CGPathCreateCopyByStrokingPath(self.indicator.path, nil, self.indicator.lineWidth, kCGLineCapButt, kCGLineJoinMiter, self.indicator.miterLimit);
    self.indicator.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    self.indicator.position = point;
    self.indicator.fillColor = color.CGColor;
}
- (void)addTapGestureRecognizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}
- (void)tapAction:(UIGestureRecognizer *)tap {
    self.selected = !_selected;
    self.tapBlock(self.index);
}
- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (selected) {
        self.titleLb.textColor = self.selectedColor ?: [UIColor orangeColor];
        self.indicator.fillColor = self.selectedColor.CGColor ?: [UIColor orangeColor].CGColor;
    } else {
        self.titleLb.textColor = [UIColor grayColor];
        self.indicator.fillColor = [UIColor grayColor].CGColor;
    }
    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    animation.duration = 1;
//    animation.fromValue=[NSNumber numberWithFloat:M_PI * !selected];
//    animation.toValue=[NSNumber numberWithFloat:M_PI * selected];
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.indicator addAnimation:animation forKey:@"demorotationAnimation"];
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.35];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = selected ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0 ];
    
    if (!anim.removedOnCompletion) {
        [self.indicator addAnimation:anim forKey:anim.keyPath];
    } else {
        [self.indicator addAnimation:anim forKey:anim.keyPath];
        [self.indicator setValue:anim.values.lastObject forKeyPath:anim.keyPath];
    }
    
    [CATransaction commit];
}
#pragma  mark lazy
- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [UILabel new];
        [self addSubview:_titleLb];
        _titleLb.text = @"过滤";
        _titleLb.textColor = [UIColor grayColor];
        _titleLb.font = [UIFont systemFontOfSize:14.5];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
        }];
        _titleLb.userInteractionEnabled = NO;
    }
    return _titleLb;
}

- (CAShapeLayer *)indicator {
    if (!_indicator) {
        _indicator = [CAShapeLayer new];
        UIBezierPath *path = [UIBezierPath new];
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(8, 0)];
        [path addLineToPoint:CGPointMake(4, 5)];
        [path closePath];
        _indicator.path = path.CGPath;
        _indicator.lineWidth = 0.8;
        _indicator.fillColor = [UIColor grayColor].CGColor;
        _indicator.position = CGPointZero;
        [self.layer addSublayer:_indicator];
    }
    return _indicator;
}
@end

//FIXME:tableView的所在视图
@interface TZLFilterTableBackView()<UITableViewDelegate, UITableViewDataSource>
/** 多少列tableView */
@property(nonatomic, assign) NSInteger columns;
/** 保存最后一列选中的row */
@property(nonatomic, assign) NSInteger lastColumnRow;
@end
@implementation TZLFilterTableBackView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.TZLFilterTableBackViewDelegate && [self.TZLFilterTableBackViewDelegate respondsToSelector:@selector(menuViewIndex:numberOfRowInColumns:)]) {
        NSInteger column = [self getIndexInSubTableViewsWithTableView:tableView];
        NSInteger row = [self.TZLFilterTableBackViewDelegate menuViewIndex:self.menuViewIndex numberOfRowInColumns:column];
        return row;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TZLFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TZLFilterTableViewCell" forIndexPath:indexPath];
    NSString *title = nil;
    NSInteger column = [self getIndexInSubTableViewsWithTableView:tableView];
    if (self.TZLFilterTableBackViewDelegate && [self.TZLFilterTableBackViewDelegate respondsToSelector:@selector(menuViewIndex:titleOfRowInColumns:row:)]) {
        title = [self.TZLFilterTableBackViewDelegate menuViewIndex:self.menuViewIndex titleOfRowInColumns:column row:indexPath.row];
    }
    cell.selectedColor = self.selectedColor;
    cell.contentLb.text = title;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger column = [self getIndexInSubTableViewsWithTableView:tableView];
    if (column == self.subTableViews.count - 1) {
        self.lastColumnRow = indexPath.row;
    }
    if (self.TZLFilterTableBackViewDelegate && [self.TZLFilterTableBackViewDelegate respondsToSelector:@selector(menuViewIndex:didSelectedWithColumns:row:)]) {
        [self.TZLFilterTableBackViewDelegate menuViewIndex:self.menuViewIndex didSelectedWithColumns:column row:indexPath.row];
    }
}

/** 得到tableView在self.subTableViews的下标也就是column(列数) */
- (NSInteger)getIndexInSubTableViewsWithTableView:(UITableView *)tableView {
    NSInteger index = [self.subTableViews indexOfObject:tableView];
    return index;
}
/** 更新添加数据tableView */
- (void)updateDataWithColumns:(NSInteger)columns {
    self.columns = columns;
    if (columns > 1) {
        for (NSInteger i = 1; i < columns; i++) {
            [self addSubTableViewWithColumn:i];
        }
    } else {
        if (!self.lastColumnRow) {
            [self.tableView reloadData];
            if ([self.tableView numberOfRowsInSection:0]) {
                [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            }
        }
    }
}
- (void)addSubTableViewWithColumn:(NSInteger)column {
    NSInteger width = kScreenW / self.columns;
    if (column == 1) {
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.width.equalTo(width);
            make.top.equalTo(0);
            make.bottom.equalTo(0);
        }];
    }
    UITableView *tableView = nil;
    if (self.subTableViews.count - 1 >= column) {//在多次展开收起时已经创建的tableView直接从数组取出
        tableView = self.subTableViews[column];
    } else {//数组中没有对应的tableView 就新增
        tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.subTableViews.lastObject.mas_right).equalTo(0.6);
            make.width.equalTo(width);
            make.top.equalTo(0);
            make.bottom.equalTo(0);
        }];
        tableView.estimatedRowHeight = 35;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0.1)];
        [tableView registerClass:[TZLFilterTableViewCell class] forCellReuseIdentifier:@"TZLFilterTableViewCell"];
        [self.subTableViews addObject:tableView];
        [tableView reloadData];
        [self.tableView reloadData];
        if ([tableView numberOfRowsInSection:0]) {
            [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
        if ([self.tableView numberOfRowsInSection:0]) {
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
    }
}
#pragma  mark lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        //        _tableView.hidden = YES;
        _tableView.estimatedRowHeight = 35;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0.1)];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerClass:[TZLFilterTableViewCell class] forCellReuseIdentifier:@"TZLFilterTableViewCell"];
        [self.subTableViews addObject:_tableView];
    }
    return _tableView;
}
- (NSMutableArray<UITableView *> *)subTableViews {
    if (!_subTableViews) {
        _subTableViews = [NSMutableArray new];
    }
    return _subTableViews;
}
@end

//FIXME:UITableViewCell(每行cell样式)
@implementation TZLFilterTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self contentLb];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.contentView.backgroundColor = [UIColor whiteColor];
    if (selected) {
        self.contentLb.textColor = self.selectedColor ?: [UIColor orangeColor];
    } else {
        self.contentLb.textColor = [UIColor grayColor];
    }
}
- (UILabel *)contentLb {
    if (!_contentLb) {
        _contentLb = [UILabel new];
        [self.contentView addSubview:_contentLb];
        [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(8);
            make.left.equalTo(12);
            make.right.lessThanOrEqualTo(-12);
            make.bottom.equalTo(-8);
        }];
//        _contentLb.backgroundColor = [UIColor redColor];
//        _contentLb.textAlignment = NSTextAlignmentCenter;
        _contentLb.numberOfLines = 0;
        _contentLb.font = [UIFont systemFontOfSize:14.5];
        _contentLb.textColor = [UIColor grayColor];
        _contentLb.text = @"1111111111";
    }
    return _contentLb;
}
@end

//FIXME:TZLFilterView(这就是根View)
@interface TZLFilterView()<TZLFilterTableBackViewDelegate> {
    NSInteger tableViewHeight;
}
/** 保存顶部的按钮view */
@property(nonatomic, strong) UIView *backView;
/** 筛选按钮 */
@property(nonatomic, strong) TZLFilterMenu *fileterMenu;
/** 筛选按钮数组 */
@property(nonatomic, strong) NSMutableArray<TZLFilterMenu *> *menus;
/** tableViewBackView */
@property(nonatomic, strong) TZLFilterTableBackView *tableViewBackView;
/** tableViewBackViews countyumenus.count同步 */
@property(nonatomic, strong) NSMutableArray<TZLFilterTableBackView *> *tableViewBackViews;
/** 表示当前view是展示的还是收起的 */
@property(nonatomic, assign) BOOL isShow;

@end
@implementation TZLFilterView
- (instancetype)init {
    if (self = [super init]) {
        self.currentIndex = 0;
        tableViewHeight = 200;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self tableViewBackView];
        [self fileterMenu];
    }
    return self;
}
#pragma mark method method
- (void)reloadDataWithColumns:(NSInteger)columns {
    if ((columns) <= (self.tableViewBackView.subTableViews.count - 1)) {
        UITableView *tableView = self.tableViewBackView.subTableViews[columns];
        [tableView reloadData];
        if ([tableView numberOfRowsInSection:0]) {
            [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
    } else {
        NSLog(@"点击的cell所在的tableView没有子tableView了, 也就是叶子节点了");
    }
}
#pragma mark method action
- (void)filterActionWithMenu:(NSInteger)index {
    NSInteger number = 0;
    if (self.TZLFilterViewDelegate && [self.TZLFilterViewDelegate respondsToSelector:@selector(menuView:numberOfRowInColumns:)]) {
        number = [self.TZLFilterViewDelegate menuView:self.menus[index] numberOfRowInColumns:0];
    }
    NSInteger height = MIN(number * 35, 210);
    CGRect backViewFrame = self.backView.frame;
    
    //这时候的self.currentIndex是上次的index,表示的是切换
    if (self.currentIndex != index) {
        TZLFilterMenu *lastMens = self.menus[self.currentIndex];
        lastMens.selected = NO;
        TZLFilterTableBackView *lastBackView = self.tableViewBackViews[self.currentIndex];
        [lastBackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0);
        }];
        [self layoutIfNeeded];
        self.currentIndex = index;
        //添加数据及相关代理方法
        [self updateData];
        if (!self.isShow) {//如果不是show状态 则表示上次跟本次不是一个menu,且self被收起来了 那么本次就要展示出来
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(self.superview.frame.size.height - self.frame.origin.y);
            }];
            [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.equalTo(0);
                make.height.equalTo(backViewFrame.size.height);
            }];
            [self.superview layoutIfNeeded];
        }
        
        TZLFilterTableBackView *currentBackView = self.tableViewBackViews[index];
        [currentBackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(height);
        }];
        [UIView animateWithDuration:0.3 animations:^{
            if (!self.isShow) {
                self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
            }
            //做tableView的动画
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.isShow = YES;
        }];
    } else {
        self.currentIndex = index;
        TZLFilterMenu *sender = self.menus[index];
        
        //如果是展示 先设置约束 再做动画
        if (sender.selected) {//展示
            //添加数据及相关代理方法
            [self updateData];
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(self.superview.frame.size.height - self.frame.origin.y);
            }];
            [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.equalTo(0);
                make.height.equalTo(backViewFrame.size.height);
            }];
            [self.superview layoutIfNeeded];
            self.isShow = YES;
        } else {
            self.isShow = NO;
        }
        
        [self.tableViewBackViews[self.currentIndex] mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(height * sender.selected);
        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3 * sender.selected];
            //做tableView的动画
            [self layoutIfNeeded];
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
                [self.tableViewBackViews[self.currentIndex] mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(0);
                }];
            }
        }];
    }
}

#pragma mark method private
- (void)updateData {
    if (self.TZLFilterViewDelegate && [self.TZLFilterViewDelegate respondsToSelector:@selector(numberOfColumnsInMenuView:)]) {
        NSInteger number = [self.TZLFilterViewDelegate numberOfColumnsInMenuView:self.menus[self.currentIndex]];
        [self.tableViewBackViews[self.currentIndex] updateDataWithColumns:number];
    }
    
}
/** 得到所在的tableView在数组中的index 也就是column */
- (NSInteger)getColumnWithTableView:(UITableView *)tableView {
    NSInteger index = [self.tableViewBackViews[self.currentIndex].subTableViews indexOfObject:tableView];
    return index;
}
/**
 收起折叠视图
 */
- (void)hideView {
    TZLFilterMenu *menu = self.menus[self.currentIndex];
    menu.selected = NO;
    [self filterActionWithMenu:self.currentIndex];
}
#pragma mark delete view
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hideView];
}
#pragma mark TZLFilterTableBackViewDelegate
- (NSInteger)menuViewIndex:(NSInteger)menuViewIndex numberOfRowInColumns:(NSInteger)columns {
    if (self.TZLFilterViewDelegate && [self.TZLFilterViewDelegate respondsToSelector:@selector(menuView:numberOfRowInColumns:)]) {
        NSInteger row = [self.TZLFilterViewDelegate menuView:self.menus[menuViewIndex] numberOfRowInColumns:columns];
        return row;
    }
    return 0;
}
- (NSString *)menuViewIndex:(NSInteger)menuViewIndex titleOfRowInColumns:(NSInteger)columns row:(NSInteger)row {
    NSString *title = nil;
    if (self.TZLFilterViewDelegate && [self.TZLFilterViewDelegate respondsToSelector:@selector(menuView:titleOfRowInColumns:row:)]) {
        title = [self.TZLFilterViewDelegate menuView:self.menus[menuViewIndex] titleOfRowInColumns:columns row:row];
    }
    return title;
}
- (void)menuViewIndex:(NSInteger)menuViewIndex didSelectedWithColumns:(NSInteger)columns row:(NSInteger)row {
    if (self.TZLFilterViewDelegate && [self.TZLFilterViewDelegate respondsToSelector:@selector(menuView:didSelectedWithColumns:row:)]) {
        [self.TZLFilterViewDelegate menuView:self.menus[menuViewIndex] didSelectedWithColumns:columns row:row];
    }
    
    //设置标题title
    NSString *title = nil;
    title = [self.TZLFilterViewDelegate menuView:self.menus[menuViewIndex] titleOfRowInColumns:columns row:row];
    TZLFilterMenu *menu = self.menus[menuViewIndex];
    menu.titleLb.text = title;
    
    if (columns == self.tableViewBackViews[menuViewIndex].subTableViews.count - 1) {//如果是最后一个tableView 点击就收起来
        [self hideView];
    }
}
#pragma  mark setter
- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    if (titles.count) {
        self.menus[0].titleLb.text = _titles[0];
    }
    if (titles.count > 1) {//默认是将self.filterMenu加进menus 类似tableView写法
        for (NSInteger i = 1; i < _titles.count; i++) {
            [self addMenusWithIndex:i];
            [self addTableBackView];
        }
    }
}
/** 添加menu */
- (void)addMenusWithIndex:(NSInteger)index {
    NSInteger width = kScreenW / _titles.count;
    TZLFilterMenu *fileterMenu = [TZLFilterMenu new];
    TZLFilterMenu *lastMenu = self.menus.lastObject;
    [self.backView addSubview:fileterMenu];
    if (index == 1) {
        [lastMenu mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(0);
            make.width.equalTo(width);
        }];
    }
    [fileterMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(0);
        make.left.equalTo(lastMenu.mas_right);
        if (index == _titles.count - 1) {
            make.right.equalTo(0);
        } else {
            make.width.equalTo(width);
        }
    }];
    fileterMenu.selectedColor = self.selectedColor;
    fileterMenu.titleLb.text = _titles[index];
    [self.backView layoutIfNeeded];
    [self.menus addObject:fileterMenu];
    fileterMenu.index = index;
    WK(weakSelf);
    fileterMenu.tapBlock = ^(NSInteger menuIndex){
        [weakSelf filterActionWithMenu:menuIndex];
    };
}
- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    _tableViewBackView.selectedColor = selectedColor;
    _fileterMenu.selectedColor = selectedColor;
}
/** 添加tableBackView */
- (void)addTableBackView {
//    TZLFilterTableBackView *lastBackView = self.tableViewBackViews.lastObject;
    TZLFilterTableBackView *tableBackView = [TZLFilterTableBackView new];
    [self addSubview:tableBackView];
    [tableBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.backView.mas_bottom);
        make.height.equalTo(0);
    }];
    tableBackView.selectedColor = self.selectedColor;
    tableBackView.backgroundColor = [UIColor whiteColor];
    tableBackView.TZLFilterTableBackViewDelegate = self;
    [self.tableViewBackViews addObject:tableBackView];
    tableBackView.menuViewIndex = [self.tableViewBackViews indexOfObject:tableBackView];
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

- (TZLFilterTableBackView *)tableViewBackView {
    if (!_tableViewBackView) {
        _tableViewBackView = [TZLFilterTableBackView new];
        [self addSubview:_tableViewBackView];
        [_tableViewBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(self.backView.mas_bottom);
            make.height.equalTo(0);
        }];
        _tableViewBackView.selectedColor = self.selectedColor;
        _tableViewBackView.backgroundColor = [UIColor whiteColor];
        _tableViewBackView.menuViewIndex = self.currentIndex;
        _tableViewBackView.TZLFilterTableBackViewDelegate = self;
        [self.tableViewBackViews addObject:_tableViewBackView];
    }
    return _tableViewBackView;
}
- (NSMutableArray<TZLFilterTableBackView *> *)tableViewBackViews {
    if (!_tableViewBackViews) {
        _tableViewBackViews = [NSMutableArray new];
    }
    return _tableViewBackViews;
}
- (NSMutableArray<TZLFilterMenu *> *)menus {
    if (!_menus) {
        _menus = [NSMutableArray new];
    }
    return _menus;
}
- (TZLFilterMenu *)fileterMenu {
    if (!_fileterMenu) {
        _fileterMenu = [TZLFilterMenu new];
        [self.backView addSubview:_fileterMenu];
        [_fileterMenu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(0);
            make.width.equalTo(kScreenW * 0.5);
        }];
        [self layoutIfNeeded];
        _fileterMenu.selectedColor = self.selectedColor;
        [self.menus addObject:_fileterMenu];
        _fileterMenu.index = 0;
        WK(weakSelf);
        _fileterMenu.tapBlock = ^(NSInteger menuIndex){
            [weakSelf filterActionWithMenu:menuIndex];
        };
    }
    return _fileterMenu;
}
@end
