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
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_checkView showWithDuration:2 afterDelay:0 type:KSLayAnimationTypeCheckMark];
    [_crossView showWithDuration:2 afterDelay:0 type:KSLayAnimationTypeCross];
}

@end
