//
//  LLDBViewController.m
//  DemoSet
//
//  Created by tang on 2018/1/12.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "LLDBViewController.h"

@interface LLDBViewController ()

@end

@implementation LLDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     expression 可简写为e，作用为执行一个表达式，首当其冲，它肯定可以用来查询当前堆栈变量的值。 当然e的更主要的用法是通过执行表达式，动态修改当前线程堆栈变量的值
     这里 e condition = 10 看怎么走
     
     
     po的作用为打印对象，事实上，我们可以通过help po得知，po是expression -O --的简写，我们可以通过它打印出对象，而不是打印对象的指针。而值得一提的是，在 help expression 返回的帮助信息中，我们可以知道，po命令会尝试调用对象的 description 方法来取得对象信息，因此我们也可以重载某个对象的description方法，使我们调试的时候能获得可读性更强，更全面的信息。  (在下面重写了description)  试试 po self
     
     
     p即是print，也是expression --的缩写，与po不同，它不会打出对象的详细信息，只会打印出一个$符号，数字，再加上一段地址信息。由于po命令下，对象的description 有可能被随便乱改，没有输出地址消息。
     
     */
    NSInteger condition = 0;
    NSLog(@"condition is %ld", condition);
    if (condition > 5) {
        NSLog(@"condition more than 5");
    } else {
        NSLog(@"condition less than 5");
    }
    NSLog(@"modified condition is %ld", condition);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)description {
    return @"想知道我是谁?做梦吧";
}

@end
