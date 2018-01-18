//
//  DictionaryToModelViewController.m
//  DemoSet
//
//  Created by tang on 2017/12/4.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "DictionaryToModelViewController.h"

#import "Computer.h"
#import "NSObject+KeyValues.h"
#define kSeparateLine NSLog(@"--------------------------")
@interface DictionaryToModelViewController ()
@property(nonatomic, copy) NSDictionary *dict;
@end

@implementation DictionaryToModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dict = @{ @"name": @"Dave Ping",
                   @"age": @24,
                   @"phoneNumber": @18718871111,
                   @"height": @180.5,
                   @"info": @{
                            @"address":@"Guangzhou",
                            },
                  @"computer": @{
                          @"name":@"Jack",
                          @"info":@{
                                  @"address":@"London",
                                  },
                          }
                  };
    
    [self objcWithKeyValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)objcWithKeyValues {
    Computer *computer = [Computer objectWithKeyValues:self.dict];
    NSLog(@"%@", computer);
    kSeparateLine;
    NSDictionary *dict = [computer keyValuesWithObjec];
    NSLog(@"%@", dict);
}

@end
