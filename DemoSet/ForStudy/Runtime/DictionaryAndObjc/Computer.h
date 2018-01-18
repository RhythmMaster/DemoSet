//
//  Computer.h
//  DemoSet
//
//  Created by tang on 2017/12/4.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Computer : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, copy) NSNumber *phoneNumber;
@property (nonatomic, copy) NSNumber *height;
@property (nonatomic, strong) NSDictionary *info;
@property(nonatomic, strong) Computer *computer;
@end
