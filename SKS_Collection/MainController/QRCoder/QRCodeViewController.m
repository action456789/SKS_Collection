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

@interface QRCodeViewController()<QRCodeViewDelegate>
{
    QRCodeView * _qrCodeView;
    UIImageView *_scannerView;
}
@end

@implementation QRCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self addSubViews];
}

- (void)addSubViews
{
    QRCodeView *qrCodeView = [[QRCodeView alloc] initWithFrame:self.view.bounds];
    qrCodeView.delegate = self;
    [qrCodeView startReading];
    [self.view addSubview:qrCodeView];
    _qrCodeView = qrCodeView;
    
    UIImageView *viewfinder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image-1"]];
    [self.view addSubview:viewfinder];
    viewfinder.bounds = CGRectMake(0, 0, SCREEN_WIDTH * 0.8, SCREEN_WIDTH * 0.8);
    viewfinder.center = self.view.center;
    
    QRCodeMaskView *maskView = [[QRCodeMaskView alloc] initWithFrame:self.view.bounds];
    maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    maskView.cutOutRect = viewfinder.frame;
    [self.view addSubview:maskView];
    
    UIImageView *scanLine = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"scanLine"]];
    CGFloat scanLineX = viewfinder.frame.origin.x;
    CGFloat scanLineY = viewfinder.frame.origin.y;
    CGFloat scanLineW = viewfinder.frame.size.width;
    scanLine.frame = CGRectMake(0, 10, 100, 3);
    [self.view addSubview:scanLine];
}

- (void)scannerViewStartAnimate
{

}

- (void)QRCodeView:(QRCodeView *)view scanedResultString:(NSString *)result
{
    
}
@end
