//
//  TransitionAnimationViewControllerSecond.m
//  DemoSet
//
//  Created by tang on 2018/1/17.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "TransitionAnimationViewControllerSecond.h"
#import "CustomTransitionAnimation.h"

@interface TransitionAnimationViewControllerSecond () <UINavigationControllerDelegate>

@property(nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDriven;

@end

@implementation TransitionAnimationViewControllerSecond

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.title = @"这是详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self imageView];
    
    [self setScreenEdgePanGestureRecognizer];
}

- (void)setScreenEdgePanGestureRecognizer {
    UIScreenEdgePanGestureRecognizer *gestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    gestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)gestureAction:(UIScreenEdgePanGestureRecognizer *)recognizer {
    CGFloat progress = [recognizer translationInView:self.view].x / self.view.frame.size.width * 2;
    progress = MIN(1.0, MAX(0.0, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.percentDriven = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.percentDriven updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        if (progress > 0.2) {
            [self.percentDriven finishInteractiveTransition];
        }else{
            [self.percentDriven cancelInteractiveTransition];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delete navigation
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        CustomTransitionAnimation *transitionAnimation = [[CustomTransitionAnimation alloc] init];
        return transitionAnimation;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.percentDriven;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        [self.view addSubview:_imageView];
        //_imageView.frame = CGRectMake(100, 100, 60, 120);
        _imageView.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5);
        UIImage *image = [UIImage imageNamed:@"未命名"];
        _imageView.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
        _imageView.image = image;
    }
    return _imageView;
}

@end
