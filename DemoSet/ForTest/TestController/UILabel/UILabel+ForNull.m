//
//  UILabel+ForNull.m
//  DemoSet
//
//  Created by tang on 2018/2/5.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "UILabel+ForNull.h"
#import <objc/runtime.h>

@implementation UILabel (ForNull)
+ (void)load {
    //[super load];
    Method fromMethod = class_getInstanceMethod([self class], @selector(setText:));
    Method toMethod = class_getInstanceMethod([self class], @selector(swizzlingSetText:));
    method_exchangeImplementations(fromMethod, toMethod);
    
}
- (void)swizzlingSetText:(NSString *)text {
//    NSLog(@"%s", __func__);
    if ([text isEqualToString:@"(null)"]) {
        text = @"...";
    }
    [self swizzlingSetText:text];
}
@end
