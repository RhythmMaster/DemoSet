//
//  CustomTransitionAnimation.m
//  DemoSet
//
//  Created by tang on 2018/1/17.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "CustomTransitionAnimation.h"
#import "TransitionAnimationViewControllerFirst.h"
#import "TransitionAnimationViewControllerSecond.h"

@interface CustomTransitionAnimation ()
@property(nonatomic, assign) BOOL flag;
@end

@implementation CustomTransitionAnimation
- (instancetype)initWithFlag:(BOOL)flag {
    if (self = [super init]) {
        self.flag = flag;
    }
    return self;
}
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (TransitionAnimationViewControllerFirst *)extracted:(id<UIViewControllerContextTransitioning> _Nonnull)transitionContext {
    TransitionAnimationViewControllerFirst *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    return fromVC;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;
    if (self.flag) {//push
        TransitionAnimationViewControllerFirst * fromVC = [self extracted:transitionContext];
        TransitionAnimationViewControllerSecond *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        UIView *animationView = [fromVC getSelectedCell];
        //由于animationView所在的视图是滚动视图 他的坐标不是屏幕坐标 需要减去偏移量
        UIScrollView *superView = (UIScrollView *)animationView.superview;
        UIView *snapShotView = [animationView snapshotViewAfterScreenUpdates:NO];
        snapShotView.frame = [containerView convertRect:animationView.frame fromView:fromVC.view];
        CGRect snapFrame = snapShotView.frame;
        snapFrame.origin.y -= superView.contentOffset.y;
        snapShotView.frame = snapFrame;
        animationView.hidden = YES;
        
        UIImageView *toView = toVC.imageView;
        toView.hidden = YES;
        CGRect toVCFinalFrame = [transitionContext finalFrameForViewController:toVC];
        toVC.view.frame = toVCFinalFrame;
        toVC.view.alpha = 0;
        

        [containerView addSubview:toVC.view];
        [containerView addSubview:snapShotView];
        
        [UIView animateWithDuration:0.5 animations:^{
            //toVC.view.frame = toVCFinalFrame;
            toVC.view.alpha = 1;
            snapShotView.frame = [containerView convertRect:toView.frame fromView:toVC.view];
            NSLog(@"----%@", NSStringFromCGRect(containerView.frame));
            NSLog(@"%@", containerView.superview);
        } completion:^(BOOL finished) {
            animationView.hidden = NO;
            toView.hidden = NO;
            NSLog(@"%@", NSStringFromCGRect(toView.frame));
            NSLog(@"%@", NSStringFromCGRect(snapShotView.frame));
            [snapShotView removeFromSuperview];
            //告诉系统动画结束
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    } else {
        TransitionAnimationViewControllerSecond *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        TransitionAnimationViewControllerFirst *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        UIView *animationView = fromVC.imageView;
        UIView *snapShotView = [animationView snapshotViewAfterScreenUpdates:NO];
        snapShotView.frame = [containerView convertRect:animationView.frame fromView:fromVC.view];
        animationView.hidden = YES;
        
        UIView *toView = [toVC getSelectedCell];
        toView.hidden = YES;
        CGRect toVCFinalFrame = [transitionContext finalFrameForViewController:toVC];
        toVC.view.frame = toVCFinalFrame;
        toVC.view.alpha = 0;
        
        
        [containerView addSubview:toVC.view];
        [containerView addSubview:snapShotView];
        
        [UIView animateWithDuration:0.5 animations:^{
            //toVC.view.frame = toVCFinalFrame;
            toVC.view.alpha = 1;
            CGRect finalFram = [containerView convertRect:toView.frame fromView:toVC.view];
            UIScrollView *superView = (UIScrollView *)toView.superview;
            finalFram.origin.y -= superView.contentOffset.y;
            snapShotView.frame = finalFram;
            NSLog(@"----%@", NSStringFromCGRect(containerView.frame));
        } completion:^(BOOL finished) {
            animationView.hidden = NO;
            toView.hidden = NO;
            [snapShotView removeFromSuperview];
            //告诉系统动画结束
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
}
@end
