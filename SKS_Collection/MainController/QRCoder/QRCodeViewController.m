//
//  QRCodeViewController.m
//  SKS_Collection
//
//  Created by KeSen on 7/25/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "QRCodeViewController.h"
#import "QRCodeView.h"
#import "QRCodeMaskView.h"
#import "UIView+Frame.h"
#import <AVFoundation/AVFoundation.h>
#import "CommonMacro.h"
#import "NSString+Regular.h"

#define kViewfinderWH kScreenWidth * 0.8
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
    viewfinder.bounds = CGRectMake(0, 0, kViewfinderWH, kScreenWidth * 0.8);
    viewfinder.center = self.view.center;
    _viewfinder = viewfinder;
    [self.view addSubview:viewfinder];
    
    UIImageView *scanLine = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"scanLine"]];
    scanLine.kk_width = kViewfinderWH;
    scanLine.kk_height = 13;
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

//- (void)test:(NSString *)result {
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"扫描结果"
//                                                                             message:result
//                                                                      preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [alertController dismissViewControllerAnimated:YES completion:nil];
//        [_qrCodeView startReading];
//    }]];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
//}

#pragma mark - QRCodeViewDelegate

- (void)QRCodeView:(QRCodeView *)view scanedResultString:(NSString *)result
{
    [view stopReading];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate); // 震动
    AudioServicesPlaySystemSound (1052);// 声音
    
//    [self test:result];
    
    if (!IsValidateString(result)) {
        NSLog(@"无效的二维码");
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(qrCodeResultInvalidateCode)]) {
            [self.delegate qrCodeResultInvalidateCode];
        }
        [view startReading];
        return;
    }
    
    if (result.isMacAddress) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(qrCodeResultMacAddress:)]) {
            [self.delegate qrCodeResultMacAddress:result];
        }
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(qrCodeResultHttpAddress:)]) {
            [self.delegate qrCodeResultHttpAddress:result];
        }
    }
}


@end
