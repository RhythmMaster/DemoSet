//
//  NSObject+KeyValues.m
//  DemoSet
//
//  Created by tang on 2017/12/4.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "NSObject+KeyValues.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (KeyValues)
//字典转模型
+ (id)objectWithKeyValues:(NSDictionary *)dictoniary {
    id objc = [[self alloc] init];
    for (NSString *key in dictoniary.allKeys) {
        id value = dictoniary[key];
        
        /* 判断当前属性是不是Model */
        objc_property_t property = class_getProperty(self, key.UTF8String);
        unsigned int count = 0;
        objc_property_attribute_t *attributes = property_copyAttributeList(property, &count);
        objc_property_attribute_t attribute = attributes[0];
        NSString *typeString = [NSString stringWithUTF8String:attribute.value];
        if ([typeString isEqualToString:@"@\"Computer\""]) {
            [self objectWithKeyValues:value];
        }
        
        /* 生成setter方法 并objc_msgSend发送 */
        NSString *methodName = [NSString stringWithFormat:@"set%@%@:", [key substringToIndex:1].uppercaseString, [key substringFromIndex:1]];
        SEL setter = sel_registerName(methodName.UTF8String);
        if ([objc respondsToSelector:setter]) {
            ((void(*) (id, SEL, id))objc_msgSend)(objc, setter, value);
        }
        free(attributes);
    }
    return objc;
}
//模型转字典
- (NSDictionary *)keyValuesWithObjec {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int count = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertys[i];
        
        //生成getter方法 并使用objc_msgSend调用
        const char *propertyName = property_getName(property);
        SEL getter = sel_registerName(propertyName);
        if ([self respondsToSelector:getter]) {
            id value = ((id (*) (id, SEL))objc_msgSend)(self, getter);
            
            if ([value isKindOfClass:[self class]] && value) {
                value = [self keyValuesWithObjec];
            }
            
            if (value) {
                NSString *key = [NSString stringWithUTF8String:propertyName];
                [dict setValue:value forKey:key];
            }
        }
    }
    free(propertys);
    return dict;
}

@end
