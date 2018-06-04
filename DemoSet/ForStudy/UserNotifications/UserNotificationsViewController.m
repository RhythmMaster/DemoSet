//
//  UserNotificationsViewController.m
//  DemoSet
//
//  Created by tang on 2018/3/13.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "UserNotificationsViewController.h"

#import "LocalNotificationsViewController.h"
#import "RemoteNotificationsViewController.h"

@interface UserNotificationsViewController ()

@end

@implementation UserNotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)dataArr {
    return @[@"本地消息推送demo", @"远程消息推送"];
}

- (NSArray *)controllerArr {
    return @[[LocalNotificationsViewController class], [RemoteNotificationsViewController class]];
}
@end
