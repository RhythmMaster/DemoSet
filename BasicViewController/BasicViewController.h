//
//  BasicViewController.h
//  DemoSet
//
//  Created by tang on 2017/12/7.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicViewController : UIViewController
@property(nonatomic, copy) NSArray *dataArr;
@property(nonatomic, copy) NSArray *controllerArr;
/** 更新tableView.frame */
@property(nonatomic, assign) CGRect tableViewFrame;
@end
