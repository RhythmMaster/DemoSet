//
//  Computer.m
//  DemoSet
//
//  Created by tang on 2017/12/4.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "Computer.h"

@implementation Computer
- (NSString *)description {
    NSString *string = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@",self.name, self.age, self.phoneNumber, self.height, self.info, self.computer];
    return string;
}
@end
