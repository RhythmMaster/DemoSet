//
//  Person.m
//  DemoSet
//
//  Created by tang on 2017/12/1.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "Person.h"

@implementation Person
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
    }
    return self;
}
- (NSString *)description {
    NSString *string = [NSString stringWithFormat:@"%@,%ld,%@", self.name, self.age, self.gender];
    return  string;
}
@end
