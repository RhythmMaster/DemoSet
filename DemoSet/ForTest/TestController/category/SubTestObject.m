//
//  SubTestObject.m
//  DemoSet
//
//  Created by tang on 2018/1/3.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "SubTestObject.h"

@implementation SubTestObject

/*
 分类 跟本类(NSObject) 同时实现了分类里面定义的方法  优先执行分类中的方法
 如果某个类(Person)继承了 有分类的类(NSObject) 那么同时继承这个类(NSObject)的分类里面的方法,如果这个子类(Person)也实现了分类的方法 那么将会优先这个子类(Person)的实现
 */

- (void)test {
    NSLog(@"这是子类: %s", __func__);
}
@end
