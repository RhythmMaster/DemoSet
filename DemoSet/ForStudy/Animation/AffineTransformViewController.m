//
//  AffineTransformViewController.m
//  DemoSet
//
//  Created by tang on 2017/11/29.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "AffineTransformViewController.h"

@interface AffineTransformViewController ()
@property (weak, nonatomic) IBOutlet UIView *demoView;

@end

@implementation AffineTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.demoView.bounds = CGRectMake(0, 0, 100, 100);
    self.demoView.center = CGPointMake(200, 200);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)translation:(id)sender {
    self.demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2 animations:^{
        // x,y平移的距离
        self.demoView.transform = CGAffineTransformMakeTranslation(100, 100);
    }];
    
}
- (IBAction)scale:(id)sender {
    self.demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2 animations:^{
        self.demoView.transform = CGAffineTransformMakeScale(2, 2);
    }];
}
- (IBAction)rotate:(id)sender {
    self.demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2 animations:^{
        self.demoView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}
- (IBAction)combo:(id)sender {
    self.demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2 animations:^{
        self.demoView.transform = CGAffineTransformMakeTranslation(100, 100);
        self.demoView.transform = CGAffineTransformMakeScale(2, 2);
        self.demoView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}
- (IBAction)invert:(id)sender {
    self.demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:2 animations:^{
        self.demoView.transform = CGAffineTransformInvert(CGAffineTransformMakeScale(2, 2));
    }];
}



@end
