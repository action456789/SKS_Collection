//
//  CheckMarkAnimVc.m
//  SKS_Collection
//
//  Created by KeSen on 8/10/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "CheckMarkAnimVc.h"
#import "KSLayAnimationView.h"
#import "UIView+Frame.h"

@implementation CheckMarkAnimVc
{
    KSLayAnimationView *_checkView;
    KSLayAnimationView *_crossView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    KSLayAnimationView *checkView = [KSLayAnimationView layAnimationView];
    [checkView setCenter:self.view.center];
    checkView.backgroundColor = [UIColor blackColor];
    _checkView = checkView;
    [self.view addSubview:checkView];
    
    KSLayAnimationView *crossView = [KSLayAnimationView layAnimationView];
    crossView.x = checkView.x;
    crossView.y = checkView.y + 50;
    crossView.backgroundColor = [UIColor blackColor];
    _crossView = crossView;
    [self.view addSubview:crossView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_checkView showWithDuration:1 afterDelay:0 type:KSLayAnimationTypeCheckMark];
        [_crossView showWithDuration:1 afterDelay:0 type:KSLayAnimationTypeCross];
    });
}

@end
