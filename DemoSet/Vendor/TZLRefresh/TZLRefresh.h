//
//  TZLRefresh.h
//  DemoSet
//
//  Created by tang on 2017/11/8.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZLRefresh : UIView
//要刷新的滚动视图
@property(nonatomic, weak) UIScrollView *refreshView;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
- (void)endRefresh;
@end
