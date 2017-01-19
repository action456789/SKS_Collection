//
//  ModalToViewController.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/17.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "ModalToViewController.h"

#import "PresentBottomUpTransitioning.h"

@interface ModalToViewController () 

@end

@implementation ModalToViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
