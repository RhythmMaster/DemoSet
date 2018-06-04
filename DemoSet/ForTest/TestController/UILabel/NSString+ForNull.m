//
//  NSString+ForNull.m
//  DemoSet
//
//  Created by tang on 2018/2/5.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "NSString+ForNull.h"
#import <objc/runtime.h>

@implementation NSString (ForNull)

//+ (void)load {
//    [super load];
//    //获取替换后的类方法
//    Method newMethod = class_getClassMethod([self class], @selector(stringWithFormat:));
//    //获取替换前的类方法
//    Method method = class_getClassMethod([self class], @selector(swizzlingStringWithFormat:));
//    //然后交换类方法
//    method_exchangeImplementations(newMethod, method);
//}

+ (instancetype)swizzlingStringWithFormat:(NSString *)format, ... {
    NSString *string = nil;
    if (format == nil) {
        string = [self swizzlingStringWithFormat:@"%@", format];
        if ([string isEqualToString:@"(null)"]) {
            string = @"...";
        }
    }
    return string;
}

@end
