//
//  NumberIncresingVc.m
//  SKS_Collection
//
//  Created by KeSen on 8/10/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "NumberIncresingVc.h"
#import "KSNumberIncreaseAnimationView.h"

@implementation NumberIncresingVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    KSNumberIncreaseAnimationView *incressingView = [[KSNumberIncreaseAnimationView alloc] initWithFrame:CGRectMake(0, 0, 200, 200) number:200];
    incressingView.center = self.view.center;
    [incressingView showFromNumber:200 toNumber:1000 WithDuration:10 delay:0];
    
    [self.view addSubview:incressingView];
}

@end
