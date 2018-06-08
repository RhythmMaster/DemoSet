//
//  ResponderChainViewController.m
//  DemoSet
//
//  Created by tang on 2018/6/6.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "ResponderChainViewController.h"
#import "UIView+Responder.h"

@interface AView: UIView
@end
@implementation AView
@end
@interface BView: UIView
@end
@implementation BView
@end
@interface CView: UIView
@end
@implementation CView
@end
@interface DView: UIView
@end
@implementation DView
@end

@interface ResponderChainViewController () {
    AView *aView;
    BView *bView;
    CView *cView;
    DView *dView;
}

@end

@implementation ResponderChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //看效果把下面注释打开
//    [self.view setChange];
    
    aView = [AView new];
    [self.view addSubview:aView];
    [aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
        make.size.equalTo(CGSizeMake(300, 300));
    }];
    aView.backgroundColor = [UIColor redColor];
//    aView.text = @"aView";
    
    bView = [BView new];
    [aView addSubview:bView];
    [bView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(30);
        make.centerX.equalTo(0);
        make.size.equalTo(CGSizeMake(150, 150));
    }];
    bView.backgroundColor = [UIColor orangeColor];
//    bView.text = @"bView";
    
    cView = [CView new];
    [bView addSubview:cView];
    [cView mas_makeConstraints:^(MASConstraintMaker *make) {
        /**
         cView也就是蓝色视图 突出了30px,这个突出部分是不能响应点击事件的
         原因: 点击事件分为事件链及响应链 点击先事件链 :
         点在UIWindow里 -> 点在UILayoutContainerView里 -> 点在UINavigationTransitionView里 -> 点在UIViewControllerWrapperView里 -> 点在UIView里 -> 点在AView里 -> 点不在BView里 (注: 到这里事件没法传递到cView,所以就不存在对应的cView响应了,aView倒是可以响应)
                <> 点不在DView里                      <> 点不在UINavigationBar里
        */
        make.top.equalTo(-30);
        make.centerX.equalTo(0);
        make.size.equalTo(CGSizeMake(100, 100));
    }];
    cView.backgroundColor = [UIColor blueColor];
//    cView.text = @"cView";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aViewAction)];
    [cView addGestureRecognizer:tap];
    
    dView = [DView new];
    [aView addSubview:dView];
    [dView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-30);
        make.centerX.equalTo(0);
        make.size.equalTo(CGSizeMake(80, 80));
    }];
    dView.backgroundColor = [UIColor grayColor];
//    dView.text = @"dView";
}
- (void)aViewAction {
    NSLog(@"单击");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
