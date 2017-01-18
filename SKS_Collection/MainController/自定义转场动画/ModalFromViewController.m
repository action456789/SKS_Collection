//
//  ModalFromViewController.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/17.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "ModalFromViewController.h"
#import "ModalToViewController.h"

#import "ModalPopTransitioning.h"
#import "ModalPushTransitioning.h"

@interface ModalFromViewController ()

@end

@implementation ModalFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.delegate = self;
}

# pragma mark - <UIViewControllerTransitioningDelegate>

// 直接两个VC之间的present和dismiss的情况下

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [ModalPushTransitioning new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [ModalPopTransitioning new];
}

#pragma mark - <UINavigationControllerDelegate>

// UINavigationController 控制两个VC的情况下

//- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                            animationControllerForOperation:(UINavigationControllerOperation)operation
//                                                         fromViewController:(UIViewController *)fromVC
//                                                           toViewController:(UIViewController *)toVC {
//    if (operation == UINavigationControllerOperationPush) {
//        return [ModalPushTransitioning new];
//    } else if (operation == UINavigationControllerOperationPop) {
//        return [ModalPopTransitioning new];
//    } else {
//        return nil;
//    }
//}

- (IBAction)buttonEvent:(id)sender {
    ModalToViewController *toVC = [[ModalToViewController alloc] initWithNibName:nil bundle:nil];
    
    //    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
    //        toVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    //    }else{
    //        self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    //    }
    toVC.transitioningDelegate = self;
    [self presentViewController:toVC animated:YES completion:nil];
}

@end
