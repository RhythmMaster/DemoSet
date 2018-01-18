//
//  SublayerTransformViewController.m
//  DemoSet
//
//  Created by tang on 2017/12/7.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "SublayerTransformViewController.h"

@interface SublayerTransformViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *layer1;
@property (weak, nonatomic) IBOutlet UIImageView *layer2;

@end

@implementation SublayerTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500;
    self.containerView.layer.sublayerTransform = perspective;
    
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.layer1.layer.transform = transform1;
    
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    self.layer2.layer.transform = transform2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
