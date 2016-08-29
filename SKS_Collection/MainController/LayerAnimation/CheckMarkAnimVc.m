//
//  CheckMarkAnimVc.m
//  SKS_Collection
//
//  Created by KeSen on 8/10/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "CheckMarkAnimVc.h"
#import "CrossAnimationView.h"
#import "CheckMarkAnimationView.h"
#import "UIView+Frame.h"
#import "CicleAnimationView.h"

@implementation CheckMarkAnimVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CheckMarkAnimationView *checkMark = [[CheckMarkAnimationView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    checkMark.backgroundColor = [UIColor blackColor];
    [self.view addSubview:checkMark];
    
    CrossAnimationView *cross = [[CrossAnimationView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    cross.backgroundColor = [UIColor blackColor];
    [self.view addSubview:cross];
    
    CicleAnimationView *progressView = [[CicleAnimationView alloc] initWithFrame:CGRectMake(0, 300, 100, 100)];
    progressView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:progressView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [checkMark showWithDuration:2.0 afterDelay:0];
        [cross showWithDuration:2.0 afterDelay:0];
        [progressView showWithProgress:1.0];
    });
}

@end
