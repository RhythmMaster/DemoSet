//
//  ThirdThenFirstViewController.m
//  DemoSet
//
//  Created by tang on 2017/11/14.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "ThirdThenFirstViewController.h"

@interface ThirdThenFirstViewController () <CALayerDelegate>
@property(nonatomic, strong) CALayer *layer;
@end

@implementation ThirdThenFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self tzl_setLayer];
    [self tzl_setLayer1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tzl_setLayer {
    CGRect bounds = CGRectMake(0, 0, 100, 100);
    CGPoint position = CGPointMake(100, 200);
    CALayer *shadowLayer = [CALayer new];
    shadowLayer.bounds = bounds;
    shadowLayer.position = position;
    shadowLayer.shadowOffset = CGSizeMake(2, 1);
    shadowLayer.shadowColor = [UIColor grayColor].CGColor;
    shadowLayer.shadowOpacity = 1;
    shadowLayer.borderWidth = 2;
    shadowLayer.cornerRadius = 50;
    shadowLayer.borderColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:shadowLayer];
    
    CALayer *layer = [CALayer new];
    layer.bounds = bounds;
    layer.position = position;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.delegate = self;
    layer.cornerRadius = 50;
    layer.masksToBounds = YES;
    //利用图层形变解决图像倒立问题
    layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    //必须调用  不然代理方法不走
    [layer setNeedsDisplay];
    self.layer = layer;
    [self.view.layer addSublayer:layer];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    //这个必须写  不写返回内存没有释放  会崩溃
    self.layer.delegate = nil;
}

//只是展示一张图片不用使用代理方法那么麻烦
- (void)tzl_setLayer1 {
    CGRect bounds = CGRectMake(0, 0, 100, 100);
    CGPoint position = CGPointMake(100, 400);
    CALayer *shadowLayer = [CALayer new];
    shadowLayer.bounds = bounds;
    shadowLayer.position = position;
    shadowLayer.shadowOffset = CGSizeMake(2, 1);
    shadowLayer.shadowColor = [UIColor grayColor].CGColor;
    shadowLayer.shadowOpacity = 1;
    shadowLayer.borderWidth = 2;
    shadowLayer.cornerRadius = 50;
    shadowLayer.borderColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:shadowLayer];
    
    CALayer *layer = [CALayer new];
    layer.bounds = bounds;
    layer.position = position;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = 50;
    layer.masksToBounds = YES;
    UIImage *image = [UIImage imageNamed:@"未命名"];
    [layer setContents:(id)image.CGImage];
    [self.view.layer addSublayer:layer];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    UIImage *image = [UIImage imageNamed:@"未命名"];
    CGContextDrawImage(ctx, CGRectMake(0, 0, 100, 100), image.CGImage);
}

@end
