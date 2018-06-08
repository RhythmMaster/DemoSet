//
//  NSArray+TZLArray.m
//  DemoSet
//
//  Created by tang on 2017/12/6.
//  Copyright © 2017年 HZ. All rights reserved.
//
/*
 对NSArray、NSMutableArray、NSDictionary、NSMutableDictionary等类进行Method Swizzling，实现方式还是按照上面的例子来做。但是....你发现Method Swizzling根本就不起作用，代码也没写错啊，到底是什么鬼？
 
 这是因为Method Swizzling对NSArray这些的类簇是不起作用的。因为这些类簇类，其实是一种抽象工厂的设计模式。抽象工厂内部有很多其它继承自当前类的子类，抽象工厂类会根据不同情况，创建不同的抽象对象来进行使用。例如我们调用NSArray的objectAtIndex:方法，这个类会在方法内部判断，内部创建不同抽象类进行操作。
 
 所以也就是我们对NSArray类进行操作其实只是对父类进行了操作，在NSArray内部会创建其他子类来执行操作，真正执行操作的并不是NSArray自身，所以我们应该对其“真身”进行操作。
 NSArray                  __NSArrayI        objc_getClass("__NSArrayI")
 NSMutableArray           __NSArrayM        objc_getClass("__NSArrayM")
 NSDictionary             __NSDictionaryI   objc_getClass("__NSDictionaryI")
 NSMutableDictionary      __NSDictionaryM   objc_getClass("__NSDictionaryM")
 */
#import "NSArray+TZLArray.h"
#import <objc/runtime.h>

@implementation NSArray (TZLArray)

+ (void)load {
    [super load];
//    SEL fromSel = @selector(objectAtIndex:);
//    SEL toSel = @selector(tzl_objectAtIndex:);
//    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), fromSel);
//    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), toSel);
//    BOOL isAdd = class_addMethod([self class], fromSel, method_getImplementation(toMethod), method_getTypeEncoding(toMethod));
//    if (isAdd) {
//        class_replaceMethod([self class], toSel, method_getImplementation(fromMethod), method_getTypeEncoding(fromMethod));
//    } else {
//        method_exchangeImplementations(fromMethod, toMethod);
//    }
}

- (id)tzl_objectAtIndex:(NSUInteger)index {
    if (self.count - 1 < index) {
        @try {
            return [self tzl_objectAtIndex:index];
        }
        @catch (NSException *excrption) {
            // 在崩溃后会打印崩溃信息，方便我们调试。
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [excrption callStackSymbols]);
            return nil;
        }
        @finally {}
    } else {
        return [self tzl_objectAtIndex:index];
    }
}

@end
