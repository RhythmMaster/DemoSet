//
//  SubMasonaryViewController.m
//  DemoSet
//
//  Created by tang on 2018/6/5.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "SubMasonaryViewController.h"

@interface SubMasonaryViewController ()
/**  */
@property(nonatomic, assign) MyEnum value;
@end

@implementation SubMasonaryViewController
- (instancetype)initWithValue:(MyEnum)value {
    if (self = [super init]) {
        self.value = value;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}

- (void)initUI {
    switch (self.value) {
        //这里我们在两个子view之间互相设置的约束 可以看到他们的宽度在约束下自动的被计算出来了
        case MyEnumValueA:
        {
            NSInteger padding = 10;
            UIView *view1 = [UIView new];
            [self.view addSubview:view1];
            UIView *view2 = [UIView new];
            [self.view addSubview:view2];
            view1.backgroundColor = [UIColor orangeColor];
            view2.backgroundColor = [UIColor orangeColor];
            [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(0);
                make.left.equalTo(padding);
                make.height.equalTo(150);
                make.width.equalTo(view2);
            }];
            [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(0);
                make.left.equalTo(view1.mas_right).equalTo(padding);
                make.right.equalTo(-padding);
                make.height.equalTo(150);
                make.width.equalTo(view1);
            }];
            break;
        }
        case MyEnumValueB:
        {
            //[中级] 在UIScrollView顺序排列一些view并自动计算contentSize
            UIScrollView *scrollView = [UIScrollView new];
            scrollView.backgroundColor = [UIColor orangeColor];
            [self.view addSubview:scrollView];
            [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(69,5,5,5));
            }];
            UIView *container = [UIView new];
            container.backgroundColor = [UIColor blueColor];
            [scrollView addSubview:container];
            [container mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(scrollView).insets(UIEdgeInsetsMake(5,5,5,5));
                make.width.equalTo(scrollView).offset(-10);
            }];
            int count = 10;
            UIView *lastView = nil;
            for ( int i = 1 ; i <= count ; ++i )
            {
                UIView *subv = [UIView new];
                [container addSubview:subv];
                subv.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                                  saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                                  brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                                       alpha:1];
                
                [subv mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.and.right.equalTo(container);
                    make.height.mas_equalTo(@(20*i));
                    
                    if ( lastView )
                    {
                        make.top.mas_equalTo(lastView.mas_bottom);
                    }
                    else
                    {
                        make.top.mas_equalTo(container.mas_top);
                    }
                }];
                
                lastView = subv;
            }
            [container mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(lastView.mas_bottom);
            }];
            break;
        }
        case MyEnumValueC:
        {
            //Masonry确定间距等间距布局
            NSInteger padding = 10;
            UIView *view1 = [UIView new];
            view1.backgroundColor = [UIColor orangeColor];
            [self.view addSubview:view1];
            UIView *view2 = [UIView new];
            view2.backgroundColor = [UIColor orangeColor];
            [self.view addSubview:view2];
            UIView *view3 = [UIView new];
            view3.backgroundColor = [UIColor orangeColor];
            [self.view addSubview:view3];
            /**
             *  确定间距等间距布局
             *
             *  @param axisType     布局方向
             *  @param fixedSpacing 两个item之间的间距(最左面的item和左边, 最右边item和右边都不是这个)
             *  @param leadSpacing  第一个item到父视图边距
             *  @param tailSpacing  最后一个item到父视图边距
             */
            [@[view1, view2, view3] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:padding leadSpacing:padding tailSpacing:padding];
            //要注意的是, 这个方法仅仅完成了水平方向的布局, 如果想确定这几个View的位置, 还需要指定竖直方向位置和高度, 这里可以用数组直接调用
            [@[view1, view2, view3] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(0);
                make.height.equalTo(view3.mas_width);
            }];
            break;
        }
        case MyEnumValueD:
        {
            //Masonry确定每个item长度等间距布局
            NSInteger padding = 70;
            UIView *view1 = [UIView new];
            view1.backgroundColor = [UIColor orangeColor];
            [self.view addSubview:view1];
            UIView *view2 = [UIView new];
            view2.backgroundColor = [UIColor orangeColor];
            [self.view addSubview:view2];
            UIView *view3 = [UIView new];
            view3.backgroundColor = [UIColor orangeColor];
            [self.view addSubview:view3];
            [@[view1, view2, view3] mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:80 leadSpacing:padding tailSpacing:padding];
            //要注意的是, 这个方法仅仅完成了水平方向的布局, 如果想确定这几个View的位置, 还需要指定竖直方向位置和高度, 这里可以用数组直接调用
            [@[view1, view2, view3] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(0);
                make.width.equalTo(view3.mas_height);
            }];
            break;
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
