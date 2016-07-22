//
//  BaseNavigationController.m
//  SKS_Collection
//
//  Created by KeSen on 7/22/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController() <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak BaseNavigationController *weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

@end
