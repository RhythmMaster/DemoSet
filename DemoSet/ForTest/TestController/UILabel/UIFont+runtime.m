//
//  UIFont+runtime.m
//  XueWeiTrain
//
//  Created by chen on 2017/4/24.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "UIFont+runtime.h"
#import <objc/runtime.h>

#define UIScreenWidth 414

@implementation UIFont (runtime)


//+ (void)load {
//    //获取替换后的类方法
//    Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
//    //获取替换前的类方法
//    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
//    //然后交换类方法
//    method_exchangeImplementations(newMethod, method);
//    
//    Method newMethodO = class_getClassMethod([self class], @selector(adjustFontWithName:size:));
//    Method methodO = class_getClassMethod([self class], @selector(fontWithName:size:));
//    method_exchangeImplementations(newMethodO, methodO);
//}

+ (UIFont *)adjustFont:(CGFloat)fontSize {
    UIFont *newFont=nil;
    newFont = [UIFont adjustFont:
               fontSize * [UIScreen mainScreen].bounds.size.width / UIScreenWidth];
    return newFont;
}
+ (UIFont *)adjustFontWithName:(NSString *)fontName size:(CGFloat)fontSize {
    UIFont *newFont=nil;
    newFont = [UIFont adjustFontWithName:fontName size:
               fontSize * [UIScreen mainScreen].bounds.size.width / UIScreenWidth];
    return newFont;
}

@end
