//
//  CaculaterViewController.m
//  SKS_Collection
//
//  Created by KeSen on 9/7/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "CaculaterViewController.h"
#import "Cachulator.h"

#import "KKGCDTimer.h"

@implementation CaculaterViewController
{
    KKGCDTimer *_timer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Cachulator *cachulator = [Cachulator new];
    cachulator.add(3).minus(1).multiply(5).divide(2);// (3 - 1) * 5 / 2
    
    _timer = [KKGCDTimer scheduledTimerWithTimeInterval:1.0 queue:dispatch_get_main_queue() repeats:YES delay:3 block:^{
        cachulator.add(1);
        
        NSLog(@"%f", cachulator.result);
        
        if (cachulator.result == 10) {
            [self->_timer invalidate];
        }
    }];
}

@end
