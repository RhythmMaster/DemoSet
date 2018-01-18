//
//  TransitionAnimationViewController.m
//  DemoSet
//
//  Created by tang on 2017/11/28.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "TransitionAnimationViewController.h"

@interface TransitionAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *demoView;
@property (weak, nonatomic) IBOutlet UILabel *demoLabel;

@end

@implementation TransitionAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.demoView.bounds = CGRectMake(0, 0, 200, 300);
    self.demoView.center = CGPointMake(self.view.center.x, 300);
    
    self.demoLabel.bounds = CGRectMake(0, 0, 20, 40);
    self.demoLabel.center = CGPointMake(self.demoView.frame.size.width * .5, self.demoView.frame.size.height * .5);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)fade:(id)sender {
    [self changeView:YES];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromRight;
    animation.duration = 2;
    [self.demoView.layer addAnimation:animation forKey:@"fadeAnimation"];
}
- (IBAction)moveIn:(id)sender {
    [self changeView:YES];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromRight;
    animation.duration = 2;
    [self.demoView.layer addAnimation:animation forKey:@"fadeAnimation"];
}
- (IBAction)push:(id)sender {
    [self changeView:YES];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    animation.duration = 2;
    [self.demoView.layer addAnimation:animation forKey:@"fadeAnimation"];
}
- (IBAction)reveal:(id)sender {
    [self changeView:YES];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromRight;
    animation.duration = 2;
    [self.demoView.layer addAnimation:animation forKey:@"fadeAnimation"];
}
//------------------------------------private api--------------------------------//
- (IBAction)cube:(id)sender {
    [self changeView:YES];
    CATransition *animation = [CATransition animation];
    animation.type = @"cube";
    animation.subtype = kCATransitionFromRight;
    animation.duration = 2;
    [self.demoView.layer addAnimation:animation forKey:@"fadeAnimation"];
}
- (IBAction)suck:(id)sender {
    [self changeView:YES];
    CATransition *animation = [CATransition animation];
    animation.type = @"suckEffect";
    animation.subtype = kCATransitionFromRight;
    animation.duration = 2;
    [self.demoView.layer addAnimation:animation forKey:@"fadeAnimation"];
}
- (IBAction)oglFilp:(id)sender {
    [self changeView:YES];
    CATransition *animation = [CATransition animation];
    animation.type = @"oglFilp";
    animation.subtype = kCATransitionFromRight;
    animation.duration = 2;
    [self.demoView.layer addAnimation:animation forKey:@"fadeAnimation"];
}
- (IBAction)ripple:(id)sender {
    [self changeView:YES];
    CATransition *animation = [CATransition animation];
    animation.type = @"rippleEffect";
    animation.subtype = kCATransitionFromRight;
    animation.duration = 2;
    [self.demoView.layer addAnimation:animation forKey:@"fadeAnimation"];
}
- (IBAction)curl:(id)sender {
    [self changeView:YES];
    CATransition *animation = [CATransition animation];
    animation.type = @"pageCurl";
    animation.subtype = kCATransitionFromRight;
    animation.duration = 2;
    [self.demoView.layer addAnimation:animation forKey:@"fadeAnimation"];
}
- (IBAction)unCurl:(id)sender {
    [self changeView:YES];
    CATransition *animation = [CATransition animation];
    animation.type = @"pageUnCurl";
    animation.subtype = kCATransitionFromRight;
    animation.duration = 2;
    [self.demoView.layer addAnimation:animation forKey:@"fadeAnimation"];
}
- (IBAction)caOpen:(id)sender {
    [self changeView:YES];
    CATransition *animation = [CATransition animation];
    animation.type = @"cameraIrisHollowOpen";
    animation.subtype = kCATransitionFromRight;
    animation.duration = 2;
    [self.demoView.layer addAnimation:animation forKey:@"fadeAnimation"];
}
- (IBAction)caClose:(id)sender {
    [self changeView:YES];
    CATransition *animation = [CATransition animation];
    animation.type = @"cameraIrisHollowClose";
    animation.subtype = kCATransitionFromRight;
    animation.duration = 2;
    [self.demoView.layer addAnimation:animation forKey:@"fadeAnimation"];
}
- (void)changeView:(BOOL)flag {
    static NSInteger index = 1;
    if (index > 2) {
        index = 0;
    }
    if (index < 0) {
        index = 2;
    }
    NSArray *colorArr = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
    NSArray *indexArr = @[@"1", @"2", @"3"];
    self.demoView.backgroundColor = colorArr[index];
    self.demoLabel.text = indexArr[index];
    flag ? index++ : index--;
}


@end
