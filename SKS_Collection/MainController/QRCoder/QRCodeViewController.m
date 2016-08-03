//
//  QRCodeViewController.m
//  SKS_Collection
//
//  Created by KeSen on 7/25/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "QRCodeViewController.h"
#import "QRCodeView.h"
#import "UIDevice+KS.h"
#import "QRCodeMaskView.h"
#import "UIView+Frame.h"
#import <AVFoundation/AVFoundation.h>

#define kViewfinderWH ScreenWidth * 0.8
#define kPadding 10

@interface QRCodeViewController()<QRCodeViewDelegate>
{
    QRCodeView * _qrCodeView;
    UIImageView *_scannerLineView;
    UIImageView *_viewfinder;
}
@end

@implementation QRCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self addSubViews];
    
    [self startScannerLineAnimation];
}

- (void)addSubViews
{
    QRCodeView *qrCodeView = [[QRCodeView alloc] initWithFrame:self.view.bounds];
    qrCodeView.delegate = self;
    [qrCodeView startReading];
    [self.view addSubview:qrCodeView];
    _qrCodeView = qrCodeView;
    
    UIImageView *viewfinder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image-1"]];
    viewfinder.bounds = CGRectMake(0, 0, kViewfinderWH, ScreenWidth * 0.8);
    viewfinder.center = self.view.center;
    _viewfinder = viewfinder;
    [self.view addSubview:viewfinder];
    
    UIImageView *scanLine = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"scanLine"]];
    scanLine.width = kViewfinderWH;
    scanLine.height = 13;
    scanLine.center = viewfinder.center;
    _scannerLineView = scanLine;
    [self.view addSubview:scanLine];
    
    QRCodeMaskView *maskView = [[QRCodeMaskView alloc] initWithFrame:self.view.bounds];
    maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    maskView.cutOutRect = viewfinder.frame;
    [self.view addSubview:maskView];
}

- (void)startScannerLineAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 3.0;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    CGFloat x = _scannerLineView.center.x;
    CGFloat y = _scannerLineView.center.y;
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(x, y - kViewfinderWH * 0.5)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(x, y + kViewfinderWH * 0.5)];
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(x, y - kViewfinderWH * 0.5)];
    
    animation.values = @[v1,v2,v3];
    
    [_scannerLineView.layer addAnimation:animation forKey:nil];
}

- (void)QRCodeView:(QRCodeView *)view scanedResultString:(NSString *)result
{
    NSLog(@"%s", __func__);
    [_qrCodeView stopReading];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate); // 震动
    AudioServicesPlaySystemSound (1052);// 声音
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"扫描结果"
                                                                             message:result
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:^{
            [_qrCodeView startReading];
        }];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
@end