//
//  Person.h
//  DemoSet
//
//  Created by tang on 2017/12/1.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>
@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, strong) NSString *gender;
- (NSString *)description;
@end
