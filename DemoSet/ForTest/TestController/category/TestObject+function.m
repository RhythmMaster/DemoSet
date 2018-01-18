//
//  TestObject+function.m
//  DemoSet
//
//  Created by tang on 2018/1/3.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "TestObject+function.h"

@implementation TestObject (function)
- (void)test {
    NSLog(@"这是分类: %s", __func__);
}
@end
