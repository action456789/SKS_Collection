//
//  CaculaterViewController.m
//  SKS_Collection
//
//  Created by KeSen on 9/7/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "CaculaterViewController.h"
#import "Cachulator.h"

@implementation CaculaterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Cachulator *cachulator = [Cachulator new];
    cachulator.add(3).minus(1).multiply(5).divide(2);// (3 - 1) * 5 / 2
    NSLog(@"%f", cachulator.result);
}

@end
