//
//  ThirdViewController.m
//  DemoSet
//
//  Created by tang on 2017/11/13.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "ThirdViewController.h"

#import "ThirdThenFirstViewController.h"

@interface ThirdViewController ()<CALayerDelegate>
@property(nonatomic, strong) CALayer *layer;
@property(nonatomic, strong) CALayer *shadowLayer;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self tzl_setLayer];
    [self tzl_setLayerWithShadow];
    [self tzl_setBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    self.layer.delegate = nil;
    self.shadowLayer.delegate = nil;
}

- (void)tzl_setLayer {
    CALayer *layer = [CALayer new];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(100, 200);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    layer.cornerRadius = 50;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 3;
    //切记: 需要注意的是上面代码中绘制图片圆形裁切效果时如果不设置masksToBounds是无法显示圆形，但是对于其他图形却没有这个限制。原因就是当绘制一张图片到图层上的时候会重新创建一个图层添加到当前图层，这样一来如果设置了圆角之后虽然底图层有圆角效果，但是子图层还是矩形，只有设置了masksToBounds为YES让子图层按底图层剪切才能显示圆角效果。同样的，有些朋友经常在网上提问说为什么使用UIImageView的layer设置圆角后图片无法显示圆角，只有设置masksToBounds才能出现效果，也是类似的问题
    //如果设置了masksToBounds=YES之后确实可以显示图片圆角效果，但遗憾的是设置了这个属性之后就无法设置阴影效果。因为masksToBounds=YES就意味着外边框不能显示，而阴影恰恰作为外边框绘制的，这样两个设置就产生了矛盾。要解决这个问题不妨换个思路:使用两个大小一样的图层，下面的图层负责绘制阴影，上面的图层用来显示图片。
    layer.masksToBounds = YES;
    
    //阴影是没用的   因为设置了asksToBounds=YES就意味着外边框不能显示  想设阴影看  下面
    layer.shadowColor=[UIColor grayColor].CGColor;
    layer.shadowOffset=CGSizeMake(2, 2);
    layer.shadowOpacity=1;
    
    layer.delegate = self;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    //调用图层setNeedDisplay,否则代理方法不会被调用
    [layer setNeedsDisplay];
    NSLog(@"tzl_setLayer: %p", layer);
}

- (void)tzl_setLayerWithShadow {
    CGRect rect = CGRectMake(0, 0, 100, 100);
    CGPoint point = CGPointMake(100, 350);
    
    CALayer *shadowLayer = [CALayer new];
    shadowLayer.bounds = rect;
    shadowLayer.position = point;
    shadowLayer.shadowOffset = CGSizeMake(2, -1);
    shadowLayer.shadowColor = [UIColor redColor].CGColor;
    shadowLayer.shadowOpacity = 1;
    shadowLayer.cornerRadius = 50;
    //设置阴影的时候要设置borderWidth
    shadowLayer.borderColor = [UIColor whiteColor].CGColor;
    shadowLayer.borderWidth = 2;
    [self.view.layer addSublayer:shadowLayer];
    
    CALayer *layer = [CALayer new];
    layer.bounds = rect;
    layer.position = point;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.masksToBounds = YES;
    layer.cornerRadius = 50;
    layer.delegate = self;
    [layer setNeedsDisplay];
    self.shadowLayer = layer;
    [self.view.layer addSublayer:layer];
    NSLog(@"tzl_setLayerWithShadow: %p, %p", shadowLayer, layer);
}

- (void)tzl_setBtn {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.bounds = CGRectMake(0, 0, 200, 30);
    button.center = CGPointMake(self.view.frame.size.width * .5, 600);
    [button setTitle:@"另一种解决图形倒立问题以及另一种设置图片" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"tzl_setBtn: %p", button);
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    //保存这之前的上下文的状态  比如 为红色  在  CGContextRestoreGState(ctx); 代码之间改变为 黄色  CGContextRestoreGState(ctx); 这个之后再看这个 上下文还是红色  相当于状态点的保存
    CGContextSaveGState(ctx);
    
    //解决图形倒立问题
    //注意: 通过指定x因子为负数，可以倒转x轴，同样可以指定y因子为负数来倒转y轴
    CGContextScaleCTM(ctx, 1, -1);
    //y轴倒转了  所以位置反了
    CGContextTranslateCTM(ctx, 0, -100);
    
    UIImage *image = [UIImage imageNamed:@"未命名"];
    CGContextDrawImage(ctx, CGRectMake(0, 0, 100, 100), image.CGImage);
    //回复保存的状态  不会影响其他操作
    CGContextRestoreGState(ctx);
    NSLog(@"drawLayer: %p", image);
}

- (void)buttonAction:(UIButton *)sender {
    ThirdThenFirstViewController *VC = [ThirdThenFirstViewController new];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
