//
//  LightControlPannelVC.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/9/1.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "LightControlPannelVC.h"
#import "LightControlPannelProgressView.h"
#import "CommonMacro.h"
#import "UIView+Frame.h"
#import <Masonry/Masonry.h>
#import "CAGradientLayer+Creator.h"
#import "UINavigationController+SubView.h"

@interface LightControlPannelVC ()
@property (weak, nonatomic) IBOutlet UIView *pannelContentView;
@property (weak, nonatomic) IBOutlet UIView *bgColorView;
@property (weak, nonatomic) IBOutlet LightControlPannelProgressView *progressView;

@end

@implementation LightControlPannelVC {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAGradientLayer *layer = [CAGradientLayer kk_layerWithFrame:[UIScreen mainScreen].bounds
                                                     startColor:kColorWithHex(0xC100C3)
                                                       endColor:kColorWithHex(0xD4436E)];
    [self.bgColorView.layer addSublayer:layer];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_progressView showWithProgress:80];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController kk_transtransparentEnable];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController kk_transtransparentDisable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}
- (IBAction)increase:(id)sender {
    [_progressView increaseWithUnit:1];
}

- (IBAction)decrease:(id)sender {
    [_progressView increaseWithUnit:-1];
}

- (IBAction)increaseLongPress:(UILongPressGestureRecognizer *)sender {
    BOOL cancel = sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled || sender.state == UIGestureRecognizerStateFailed;
    if (sender.state == UIGestureRecognizerStateBegan) {
        [_progressView startIncrease];
    } else if (cancel) {
        [_progressView endIncrease];
    }
}

- (IBAction)decreaseLongPress:(UILongPressGestureRecognizer *)sender {
    BOOL cancel = sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled || sender.state == UIGestureRecognizerStateFailed;
    if (sender.state == UIGestureRecognizerStateBegan) {
        [_progressView startDecrease];
    } else if (cancel) {
        [_progressView endDecrease];
    }
}


@end
