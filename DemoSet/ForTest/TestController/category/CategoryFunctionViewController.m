//
//  CategoryFunctionViewController.m
//  DemoSet
//
//  Created by tang on 2017/12/29.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "CategoryFunctionViewController.h"
#import "TestObject.h"
#import "SubTestObject.h"
#import "TestObject+function.h"

@interface CategoryFunctionViewController ()

@end

@implementation CategoryFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //[self.navigationController.navigationBar setTranslucent:NO];
    
    TestObject *test = [TestObject new];
    [test test];
    [TestObject categoryTestStr];
    [NSObject categoryTestStr];
    
    SubTestObject *subTest = [SubTestObject new];
    [subTest test];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
