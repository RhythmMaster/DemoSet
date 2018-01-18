//
//  PictureStretchViewController.m
//  DemoSet
//
//  Created by tang on 2017/12/20.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "PictureStretchViewController.h"

@interface PictureStretchViewController ()

@end

@implementation PictureStretchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *transformImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    transformImage.center = CGPointMake(self.view.frame.size.width * .5, self.view.frame.size.height * .5);
    transformImage.image = [UIImage imageNamed:@"bubble"];
    [self.view addSubview:transformImage];
    
    
    UIImageView *stretchImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    stretchImage.center = CGPointMake(self.view.frame.size.width * .5, self.view.frame.size.height * .5 + 100);
    UIImage *image = [UIImage imageNamed:@"bubble"];
    // 设置左边端盖宽度
    CGFloat leftCapWidth = image.size.width * .5;
    // 设置上边端盖高度
    CGFloat topCapHeight = image.size.height * .5;
    /*
     左边界到拉伸点的距离  上边界到拉伸点的距离   还有 右盖宽度 及下盖宽度  系统自动计算
     系统会自动计算rightCapWidth
     rightCapWidth = image.width - leftCapWidth - 1;
     系统会自动计算bottomCapHeight
     bottomCapHeight = image.height - topCapHeight - 1
     所以可以拉伸的的范围是 1*1 的  不会出现变形问题
     */
    UIImage *newImage = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    stretchImage.image = newImage;
    [self.view addSubview:stretchImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
