//
//  ThreeDTransitionAnimationViewController.m
//  DemoSet
//
//  Created by tang on 2017/12/7.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "ThreeDTransitionAnimationViewController.h"

@interface ThreeDTransitionAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *secondLayer;
@property (weak, nonatomic) IBOutlet UIImageView *originalLayer;
@property (weak, nonatomic) IBOutlet UIImageView *viewLayer;

@end

@implementation ThreeDTransitionAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"m34的作用";
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    self.secondLayer.layer.transform = transform;
    
    CATransform3D transform1 = CATransform3DIdentity;
    transform1.m34 = -1.0 / 500;
    transform1 = CATransform3DRotate(transform1, M_PI_4, 0, 1, 0);
    self.viewLayer.layer.transform = transform1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
