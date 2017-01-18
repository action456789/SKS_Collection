//
//  ModalTransitioning.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/17.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "ModalPushTransitioning.h"
#import "UIView+Frame.h"

@interface ModalPushTransitioning ()

@end

@implementation ModalPushTransitioning

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
    CGRect finalToViewFrame = [transitionContext finalFrameForViewController:toVC];
    
    toView.frame = initialFrame;
    [containerView addSubview:toView];
    
    //3
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    } completion:^(BOOL finished) {
        
        //4
        [transitionContext completeTransition:YES];
        
    }];
}

@end
