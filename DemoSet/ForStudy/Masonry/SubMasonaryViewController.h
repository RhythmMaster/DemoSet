//
//  SubMasonaryViewController.h
//  DemoSet
//
//  Created by tang on 2018/6/5.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MyEnum) {
    MyEnumValueA,//[初级] 让两个高度为150的view垂直居中且等宽且等间隔排列 间隔为10(自动计算其宽度)
    MyEnumValueB,//[中级] 在UIScrollView顺序排列一些view并自动计算contentSize
    MyEnumValueC,//Masonry确定间距等间距布局
    MyEnumValueD,//Masonry确定每个item长度等间距布局
};

@interface SubMasonaryViewController : UIViewController
- (instancetype)initWithValue:(MyEnum)value;
@end
