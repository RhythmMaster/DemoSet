//
//  DoubleSidedViewController.m
//  DemoSet
//
//  Created by tang on 2017/12/7.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "DoubleSidedViewController.h"

@interface DoubleSidedViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *yesLayer;
@property (weak, nonatomic) IBOutlet UIImageView *noLayer;

@end

@implementation DoubleSidedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CATransform3D yesTransform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    self.yesLayer.layer.transform = yesTransform;
    
    /* doubleSided默认是YES 背面也渲染  设成NO 背面没有被渲染  导致看不见了 */
    CATransform3D noTransform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    self.noLayer.layer.doubleSided = NO;
    self.noLayer.layer.transform = noTransform;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
