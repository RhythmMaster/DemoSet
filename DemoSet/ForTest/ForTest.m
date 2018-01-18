//
//  ForTest.m
//  DemoSet
//
//  Created by tang on 2017/11/9.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "ForTest.h"
static NSMutableArray *_testArr;
static NSString *_testmemboryAddress;
@interface ForTest()
@end
@implementation ForTest

+ (void)test_addObjecWithObjec:(id)object {
    [[self testArr] addObject:object];
    NSLog(@"%@", _testArr);
    NSLog(@"%@, %p", _testmemboryAddress, _testmemboryAddress);
    _testmemboryAddress = object;
    NSLog(@"%@, %p", _testmemboryAddress, _testmemboryAddress);
}

+ (NSMutableArray *)testArr {
    if (!_testArr) {
        _testArr = [NSMutableArray new];
    }
    return _testArr;
}
@end
