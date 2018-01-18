//
//  BeautifulGirl.h
//  DemoSet
//
//  Created by tang on 2017/12/4.
//  Copyright © 2017年 HZ. All rights reserved.
//   runtime自动归档

#import <Foundation/Foundation.h>

@interface BeautifulGirl : NSObject <NSCoding>
@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, strong) NSString *address;
@property(nonatomic, strong) NSString *phone;
- (NSString *)description;
@end
