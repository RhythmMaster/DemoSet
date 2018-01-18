//
//  NSObject+Function.m
//  DemoSet
//
//  Created by tang on 2018/1/3.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "NSObject+Function.h"

@implementation NSObject (Function)
+ (NSString *)categoryTestStr {
    NSLog(@"这是分类: %s", __func__);
    return nil;
}
@end
