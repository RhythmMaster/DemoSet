//
//  KVOSark.m
//  DemoSet
//
//  Created by tang on 2018/1/15.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "KVOSark.h"

@implementation KVOSark
- (void)willChangeValueForKey:(NSString *)key {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [super willChangeValueForKey:key];
}

- (void)didChangeValueForKey:(NSString *)key {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [super didChangeValueForKey:key];
}
@end
