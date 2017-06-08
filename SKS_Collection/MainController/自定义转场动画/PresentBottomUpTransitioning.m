//
//  ModalTransitioning.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/17.
//  Copyright © 2017年 SenKe. All rights reserved.
//
// 参考文献：https://coderwall.com/p/njtb0q/custom-transitions-on-ios-7-a-little-bit-about-ux

#import "PresentBottomUpTransitioning.h"
#import "UIView+Frame.h"

#import "ModalToViewController.h"


@interface PresentBottomUpTransitioning ()

@end

@implementation PresentBottomUpTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *destinationVC =  (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if ([destinationVC isBeingPresented]) {
        [self animatePresentation:transitionContext];
    } else {
        [self animateDismissal:transitionContext];
    }
}

// present 动画
// present 时，fromVC 已经设置好了，destinationVC 没有设置好，需要手动将 destinationVC.view 放到 containerView 中。
- (void)animatePresentation:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 1
    UIViewController *sourceVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ModalToViewController *destinationVC =  (ModalToViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // containerView 是一个 UITransitionView ，装有 toVC 的 View
    UIView *containerView = [transitionContext containerView];
    
    // 2
    CGRect initialFrame = [transitionContext initialFrameForViewController:sourceVC];
//    CGRect finalToViewFrame = [transitionContext finalFrameForViewController:destinationVC];
    
    destinationVC.view.frame = initialFrame;
    [containerView addSubview:destinationVC.view];
    
    //3
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        destinationVC.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        destinationVC.contentView.transform = CGAffineTransformMakeTranslation(0, -destinationVC.contentView.frame.size.height);
    } completion:^(BOOL finished) {
        //4
        [transitionContext completeTransition:YES];
    }];
}

// dismiss 动画
// 在 dismiss 中，所有的控制器都设置好了，不需要进行额外的操作
- (void)animateDismissal:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 1
    ModalToViewController *sourceVC = (ModalToViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    //    [containerView addSubview:toVC.view];
    
    // 需要将 fromVC.view 放到最前
    [containerView bringSubviewToFront:sourceVC.view];
    
    //3
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        sourceVC.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        sourceVC.contentView.transform = CGAffineTransformMakeTranslation(0, sourceVC.view.frame.size.height);
    } completion:^(BOOL finished) {
        //4
        [transitionContext completeTransition:YES];
        
    }];
}

@end
