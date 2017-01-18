//
//  ModalToViewController.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/17.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "ModalToViewController.h"

#import "ModalPushTransitioning.h"
#import "ModalPopTransitioning.h"

@interface ModalToViewController () 

@end

@implementation ModalToViewController

//- (instancetype)init {
//    if (self = [super init]) {
//        self.transitioningDelegate = self;
//        self.definesPresentationContext = YES;
//        self.providesPresentationContextTransitionStyle = NO;
//        self.modalPresentationStyle = UIModalPresentationCustom;
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
