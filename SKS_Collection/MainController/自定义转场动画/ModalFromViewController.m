//
//  ModalFromViewController.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/17.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "ModalFromViewController.h"
#import "ModalToViewController.h"

#import "PresentBottomUpTransitioning.h"

@interface ModalFromViewController ()

@end

@implementation ModalFromViewController

// dismiss 回来时，viewWillAppear 不会调用
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.delegate = self;
}

# pragma mark - <UIViewControllerTransitioningDelegate>

// 直接两个VC之间的present和dismiss的情况下

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [PresentBottomUpTransitioning new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [PresentBottomUpTransitioning new];
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

/*
 typedef NS_ENUM(NSInteger, UIModalPresentationStyle) {
 UIModalPresentationFullScreen = 0,
 UIModalPresentationPageSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
 UIModalPresentationFormSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
 UIModalPresentationCurrentContext NS_ENUM_AVAILABLE_IOS(3_2),
 UIModalPresentationCustom NS_ENUM_AVAILABLE_IOS(7_0),
 UIModalPresentationOverFullScreen NS_ENUM_AVAILABLE_IOS(8_0),
 UIModalPresentationOverCurrentContext NS_ENUM_AVAILABLE_IOS(8_0),
 UIModalPresentationPopover NS_ENUM_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED,
 UIModalPresentationNone NS_ENUM_AVAILABLE_IOS(7_0) = -1,
 };
 
*/
- (IBAction)buttonEvent:(id)sender {
    // setup toVC
    ModalToViewController *toVC = [[ModalToViewController alloc] initWithNibName:nil bundle:nil];
    toVC.transitioningDelegate = self;
    toVC.modalPresentationCapturesStatusBarAppearance = YES;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        toVC.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    }else{
        toVC.modalPresentationStyle = UIModalPresentationCurrentContext;
    }

    // setup fromVC
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        self.navigationController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    }else{
        self.navigationController.modalPresentationStyle=UIModalPresentationCurrentContext;
    }

    [self.navigationController presentViewController:toVC animated:YES completion:nil];
}

@end
