//
//  SubStatckViewViewController.h
//  DemoSet
//
//  Created by tang on 2018/6/6.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, MyEnum) {
    MyEnumValueA,//普通用法
    MyEnumValueB,//通过Label了解StackView的distribution
    MyEnumValueC,//通过Label了解StackView的alignment
    MyEnumValueD,//利用UIStackView的小demo
};

@interface SubStatckViewViewController : UIViewController
- (instancetype)initWithValue:(MyEnum)value;
@end
