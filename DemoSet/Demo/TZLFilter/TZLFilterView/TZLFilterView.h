//
//  TZLFilterView.h
//  DemoSet
//
//  Created by tang on 2018/6/4.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>
//FIXME:筛选的按钮View
typedef void (^tapBlock)(NSInteger index);
@interface TZLFilterMenu: UIView
/** titleLb */
@property(nonatomic, strong) UILabel *titleLb;
/** 小图标 */
@property(nonatomic, strong) UIImageView *iconImg;
/** tapBlock */
@property(nonatomic, copy) tapBlock tapBlock;
/** 在数组中所处的index */
@property(nonatomic, assign) NSInteger index;
/** bool */
@property(nonatomic, assign) BOOL selected;
/** 选择的颜色 */
@property(nonatomic, strong) UIColor *selectedColor;
@end

@protocol TZLFilterTableBackViewDelegate<NSObject>
@optional
/**
 *  返回 menu 有多少列 ，默认1列
 */
- (NSInteger)numberOfColumnsInMenuViewIndex:(NSInteger)menuViewIndex;
@required
/**
 *  返回 每列有多少行 必须实现
 */
- (NSInteger)menuViewIndex:(NSInteger)menuViewIndex numberOfRowInColumns:(NSInteger)columns;
/**
 *  返回 每列每行的title  必须实现
 */
- (NSString *)menuViewIndex:(NSInteger)menuViewIndex titleOfRowInColumns:(NSInteger)columns row:(NSInteger)row;
- (void)menuViewIndex:(NSInteger)menuViewIndex didSelectedWithColumns:(NSInteger)columns row:(NSInteger)row;
@end

//FIXME:tableView的所在视图
@interface TZLFilterTableBackView: UIView
/** 代理 */
@property(nonatomic, weak) id<TZLFilterTableBackViewDelegate> TZLFilterTableBackViewDelegate;
/** tableView */
@property(nonatomic, strong) UITableView *tableView;
/** 保存子tableView的数组 */
@property(nonatomic, strong) NSMutableArray<UITableView *> *subTableViews;
/** 保存当前view(self)所对应的筛选按钮所在的index */
@property(nonatomic, assign) NSInteger menuViewIndex;
/** 添加tableView及相关数据 */
- (void)updateDataWithColumns:(NSInteger)columns;

/** 选择的颜色 */
@property(nonatomic, strong) UIColor *selectedColor;
@end

//FIXME:UITableViewCell(每行cell样式)
@interface TZLFilterTableViewCell: UITableViewCell
/** label */
@property(nonatomic, strong) UILabel *contentLb;
/** 选择的颜色 */
@property(nonatomic, strong) UIColor *selectedColor;
@end


@protocol TZLFilterViewDelegate<NSObject>
@optional
/**
 *  返回 menu 有多少列 ，默认1列
 */
- (NSInteger)numberOfColumnsInMenuView:(TZLFilterMenu *)menuView;
@required
/**
 *  返回 每列有多少行 必须实现
 */
- (NSInteger)menuView:(TZLFilterMenu *)menuView numberOfRowInColumns:(NSInteger)columns;
/**
 *  返回 每列每行的title  必须实现
 */
- (NSString *)menuView:(TZLFilterMenu *)menuView titleOfRowInColumns:(NSInteger)columns row:(NSInteger)row;
- (void)menuView:(TZLFilterMenu *)menuView didSelectedWithColumns:(NSInteger)columns row:(NSInteger)row;
@end

//FIXME:TZLFilterView(这就是根View)
@interface TZLFilterView : UIView
/** delegate */
@property(nonatomic, weak) id<TZLFilterViewDelegate> TZLFilterViewDelegate;
/** 筛选按钮title */
@property(nonatomic, strong) NSArray *titles;
/** 当前选择的筛选按钮index */
@property(nonatomic, assign) NSInteger currentIndex;
- (void)reloadDataWithColumns:(NSInteger)columns;

//需要设置的参数
/** 选择的颜色 */
@property(nonatomic, strong) UIColor *selectedColor;
@end

