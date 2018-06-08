//
//  SubStatckViewViewController.m
//  DemoSet
//
//  Created by tang on 2018/6/6.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "SubStatckViewViewController.h"

@interface SubStatckViewViewController () {
    UIStackView *stackView;
    UIStackView *horizontalStackView;
    UIStackView *verticalStackView;
}
@property(nonatomic, assign) MyEnum value;
@end

@implementation SubStatckViewViewController
- (instancetype)initWithValue:(MyEnum)value {
    if (self = [super init]) {
        self.value = value;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.value == MyEnumValueD) {
        verticalStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64 - 50)];
        verticalStackView.axis = UILayoutConstraintAxisVertical;
        verticalStackView.spacing = 10;
        verticalStackView.distribution = UIStackViewDistributionFillEqually;
        verticalStackView.alignment = UIStackViewAlignmentFill;
        [self.view addSubview:verticalStackView];
        
        
        [self addClickEvent];
    } else {
        stackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 100, kScreenW, 300)];
        stackView.axis = UILayoutConstraintAxisHorizontal;
        stackView.distribution = UIStackViewDistributionFillEqually;
        stackView.spacing = 10;
        stackView.alignment = UIStackViewAlignmentFill;
        [self.view addSubview:stackView];
        
        [self initUI];
    }
}
- (void)addClickEvent {
    UIButton *addHorizontalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addHorizontalBtn setTitle:@"横行增加" forState:UIControlStateNormal];
    [addHorizontalBtn setTitleColor:RadomColor forState:UIControlStateNormal];
    addHorizontalBtn.frame = CGRectMake(0, 350, 100, 50);
    [addHorizontalBtn addTarget:self action:@selector(addHorizontalClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addHorizontalBtn];
    
    UIButton *removeHorizontalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [removeHorizontalBtn setTitle:@"横行减少" forState:UIControlStateNormal];
    [removeHorizontalBtn setTitleColor:RadomColor forState:UIControlStateNormal];
    removeHorizontalBtn.frame = CGRectMake(0, 400, 100, 50);
    [removeHorizontalBtn addTarget:self action:@selector(removeHorizontalClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeHorizontalBtn];
    
    UIButton *addVerticalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addVerticalBtn setTitle:@"纵行增加" forState:UIControlStateNormal];
    [addVerticalBtn setTitleColor:RadomColor forState:UIControlStateNormal];
    addVerticalBtn.frame = CGRectMake(0, 450, 100, 50);
    [addVerticalBtn addTarget:self action:@selector(addVerticalClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addVerticalBtn];
    
    UIButton *removeVerticalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [removeVerticalBtn setTitle:@"纵行减少" forState:UIControlStateNormal];
    [removeVerticalBtn setTitleColor:RadomColor forState:UIControlStateNormal];
    removeVerticalBtn.frame = CGRectMake(0, 500, 100, 50);
    [removeVerticalBtn addTarget:self action:@selector(removeVerticalClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeVerticalBtn];
}

- (void)initUI {
    switch (self.value) {
        case MyEnumValueA://普通用法
        {
            for (NSInteger i = 0; i < 4; i++) {
                UIView *view = [[UIView alloc] init];
                view.backgroundColor = [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1];
                [stackView addArrangedSubview:view];
            }
            break;
        }
        case MyEnumValueB://根据label了解UIStackView的distribution
        {
            stackView.distribution = UIStackViewDistributionFillEqually;
            UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [addBtn setTitle:@"加一个Label" forState:UIControlStateNormal];
            [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            addBtn.frame = CGRectMake(50, 400, 100, 50);
            [addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:addBtn];
            
            UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [removeBtn setTitle:@"减一个Label" forState:UIControlStateNormal];
            [removeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            removeBtn.frame = CGRectMake(200, 400, 100, 50);
            [removeBtn addTarget:self action:@selector(removeClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:removeBtn];
            
            UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [selectBtn setTitle:@"选distribution" forState:UIControlStateNormal];
            [selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            selectBtn.frame = CGRectMake(200, 500, 100, 50);
            [selectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:selectBtn];
            break;
        }
        case MyEnumValueC://根据label了解UIStackView的alignment
        {
            stackView.axis = UILayoutConstraintAxisVertical;
            stackView.alignment = UIStackViewDistributionFillEqually;
            UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [addBtn setTitle:@"加一个Label" forState:UIControlStateNormal];
            [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            addBtn.frame = CGRectMake(50, 400, 100, 50);
            [addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:addBtn];
            
            UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [removeBtn setTitle:@"减一个Label" forState:UIControlStateNormal];
            [removeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            removeBtn.frame = CGRectMake(200, 400, 100, 50);
            [removeBtn addTarget:self action:@selector(removeClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:removeBtn];
            
            UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [selectBtn setTitle:@"选alignment" forState:UIControlStateNormal];
            [selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            selectBtn.frame = CGRectMake(200, 500, 100, 50);
            [selectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:selectBtn];
            break;
        }
        default:
            break;
    }
}
- (void)addHorizontalClick {
    if (!horizontalStackView) {
        [self horizontal];
        [verticalStackView addArrangedSubview:horizontalStackView];
    }
    UIImageView *imgView = [self getDigimon];
    [horizontalStackView addArrangedSubview:imgView];
    [UIView animateWithDuration:1.0 animations:^{
        [horizontalStackView layoutIfNeeded];
    }];
    
}
- (UIImageView *)getDigimon {
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    NSString *imgName = [NSString stringWithFormat:@"222_%ld.jpg",random()%16+1];
    imgView.image = [UIImage imageNamed:imgName];
    return imgView;
}
- (void)removeHorizontalClick {
    UIImageView *imageView = horizontalStackView.subviews.lastObject;
    [horizontalStackView removeArrangedSubview:imageView];
    [imageView removeFromSuperview];
    [UIView animateWithDuration:1.0 animations:^{
        [horizontalStackView layoutIfNeeded];
    }];
}
- (void)addVerticalClick {
    UIImageView *imgView = [self getDigimon];
    [verticalStackView insertArrangedSubview:imgView atIndex:0];
    [UIView animateWithDuration:1.0 animations:^{
        [verticalStackView layoutIfNeeded];
    }];
}
- (void)removeVerticalClick {
    UIView *imageView = verticalStackView.subviews.lastObject;
    [verticalStackView removeArrangedSubview:imageView];
    [imageView removeFromSuperview];
    if (imageView == horizontalStackView) {
        horizontalStackView = nil;
    }
    [UIView animateWithDuration:1.0 animations:^{
        [verticalStackView layoutIfNeeded];
    }];
}
- (void)addClick {
    NSLog(@"添加之前:%ld", stackView.subviews.count);
    UILabel *label = [UILabel new];
    NSMutableString *str = [NSMutableString stringWithString:@"我看看"];
    label.textAlignment = NSTextAlignmentCenter;
    for (NSInteger i = 0; i < random()%4; i++) {
        [str appendString:@"我看看"];
    }
    label.text = str;
    label.backgroundColor = [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1];
    [stackView addArrangedSubview:label];
    [UIView animateWithDuration:0.3 animations:^{
        [stackView layoutIfNeeded];
    }];
    NSLog(@"添加之后:%ld", stackView.subviews.count);
}
- (void)removeClick {
    NSLog(@"删除之前:%ld", stackView.subviews.count);
    UIView *view = stackView.subviews.lastObject;
    [stackView removeArrangedSubview:view];
    [view removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        [stackView layoutIfNeeded];
    }];
    NSLog(@"删除之后:%ld", stackView.subviews.count);
}

- (void)selectAction {
    TZLPickerViewController *pickerVC = [TZLPickerViewController new];
    pickerVC.pickerType = PickerViewCustomType;
    NSArray *tmp = nil;
    if (self.value == MyEnumValueB) {
        tmp = @[@"UIStackViewDistributionFill", @"UIStackViewDistributionFillEqually",
                @"UIStackViewDistributionFillProportionally", @"UIStackViewDistributionEqualSpacing", @"UIStackViewDistributionEqualCentering"];
    }
    if (self.value == MyEnumValueC) {
        tmp = @[@"UIStackViewAlignmentFill", @"UIStackViewAlignmentLeading",
                @"UIStackViewAlignmentTop", @"UIStackViewAlignmentFirstBaseline",
                @"UIStackViewAlignmentCenter", @"UIStackViewAlignmentTrailing",
                @"UIStackViewAlignmentBottom", @"UIStackViewAlignmentLastBaseline"];
    }
    pickerVC.customArr = tmp;
    [self presentViewController:pickerVC animated:YES completion:nil];
    pickerVC.dateBlock = ^(TZLPickerDataModel *model) {
        stackView.distribution = model.indexPath.row;
    };
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark lazy
- (void)horizontal {
    horizontalStackView = [UIStackView new];
    horizontalStackView.axis = UILayoutConstraintAxisHorizontal;
    horizontalStackView.distribution = UIStackViewDistributionFillEqually;
    horizontalStackView.spacing = 10;
    horizontalStackView.alignment = UIStackViewAlignmentFill;
    horizontalStackView.backgroundColor = [UIColor orangeColor];
    
    [verticalStackView addArrangedSubview:horizontalStackView];
}

@end
