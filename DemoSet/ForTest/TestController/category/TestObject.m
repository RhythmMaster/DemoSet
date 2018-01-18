//
//  TestObject.m
//  DemoSet
//
//  Created by tang on 2017/12/29.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "TestObject.h"

@implementation TestObject
+ (NSString *)categoryTestStr {
    NSLog(@"这是原类: %s", __func__);
    return @"反悔了这是原类";
}
+ (NSString *)testCategoryTestStr {
    NSLog(@"这是原类类: %s", __func__);
    return nil;
}
- (void)test {
    NSLog(@"这是分类: %s", __func__);
}
@end
