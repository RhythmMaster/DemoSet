//
//  SelfAndSuperViewController.h
//  DemoSet
//
//  Created by tang on 2017/12/27.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfAndSuperViewController : UIViewController
@property(nonatomic, strong) NSString *test;
- (instancetype)initWithTest:(NSString *)test;
@end
