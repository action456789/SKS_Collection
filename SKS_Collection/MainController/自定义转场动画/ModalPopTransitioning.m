//
//  ModalPopTransitioning.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/18.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "ModalPopTransitioning.h"
#import "UIView+Frame.h"

@implementation ModalPopTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // 1
    UIViewController *fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC =  (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    UIView *containerView = [transitionContext containerView];
    
    // 2
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
//    CGRect finalToViewFrame = [transitionContext finalFrameForViewController:toVC];
    
    fromView.frame = initialFrame;
    [containerView addSubview:toView];
    [containerView bringSubviewToFront:fromView];
    
    //3
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        fromView.y = initialFrame.size.height;
    } completion:^(BOOL finished) {
        //4
        [fromView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}
@end
