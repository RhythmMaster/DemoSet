//
//  NSObject+KeyValues.h
//  DemoSet
//
//  Created by tang on 2017/12/4.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KeyValues)

+ (id)objectWithKeyValues:(NSDictionary *)dictoniary;

- (NSDictionary *)keyValuesWithObjec;

@end
