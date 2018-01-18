//
//  KVOTheoryViewController.m
//  DemoSet
//
//  Created by tang on 2018/1/15.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "KVOTheoryViewController.h"
#import "KVOSark.h"

@interface KVOTheoryViewController ()

@end

@implementation KVOTheoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    KVOSark *sark = [KVOSark new];
    /*
     breakpoint 1
     结果:
     (lldb) po sark.class
     KVOSark
     (lldb) po object_getClass(sark)
     KVOSark
     */
    [sark addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    /*
     breakpoint 2
     结果:
     (lldb) po sark.class
     KVOSark
     (lldb) po object_getClass(sark)
     NSKVONotifying_KVOSark
     */
    sark.name = @"Persistent";
    [sark removeObserver:self forKeyPath:@"name"];
    /*
     breakpoint 3
     结果:
     (lldb) po sark.class
     KVOSark
     (lldb) po object_getClass(sark)
     KVOSark
     */
    /*
     第一次  结论:
     上面的结果说明，在sark对象被观察时，framework使用runtime动态创建了一个Sark类的子类NSKVONotifying_Sark
     而且为了隐藏这个行为，NSKVONotifying_Sark重写了- class方法返回之前的类，就好像什么也没发生过一样
     但是使用object_getClass()时就暴露了，因为这个方法返回的是这个对象的isa指针，这个指针指向的一定是个这个对象的类对象
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"我知道了");
    }
}

@end
