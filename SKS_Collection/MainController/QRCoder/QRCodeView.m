//
//  QRCodeView.m
//  SKS_Collection
//
//  Created by KeSen on 7/25/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "QRCodeView.h"

@interface QRCodeView()<AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *_session;
    AVCaptureDevice *_captureDevice;
    AVCaptureDeviceInput *_inputDevice;
    AVCaptureVideoPreviewLayer *_previewLayer;
    
    BOOL _isRunning;
}
@end

@implementation QRCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _torchMode = AVCaptureTorchModeOff;
        [self startReading];
    }
    return self;
}

- (void)dealloc
{
    [self stopReading];
}

- (void)startReading
{
    _isRunning = YES;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _captureDevice = captureDevice;
    
    NSError *error = nil;
    AVCaptureDeviceInput *inputDevice = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:&error];
    _inputDevice = inputDevice;
    if (!inputDevice) {
        NSLog(@"%@", [error localizedDescription]);
        return;
    }

    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    _session = session;
    
    [_session addInput:_inputDevice];
    
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [_session addOutput:output];
    [output setMetadataObjectsDelegate:self
                                 queue:dispatch_queue_create("com.cn.scanQRCodeQueue", DISPATCH_QUEUE_SERIAL)];
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    previewLayer.frame = self.bounds;
    [self.layer addSublayer:previewLayer];
    _previewLayer = previewLayer;
    
    [_session startRunning];
}

- (void)stopReading
{
    if (!_isRunning) {
        return;
    }
    
    _isRunning = NO;
    
    [_session stopRunning];
    [_previewLayer removeFromSuperlayer];
    _inputDevice = nil;
    _previewLayer = nil;
    _session = nil;
}

#pragma mark - delegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (_isRunning == NO) {
        return;
    }
    
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        
        NSString *result = nil;
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            result = metadataObj.stringValue;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.delegate && [self.delegate respondsToSelector:@selector(QRCodeView:scanedResultString:)]) {
                    [self.delegate QRCodeView:self scanedResultString:result];
                }
            });
            
        } else {
            NSLog(@"不是二维码");
        }
    }
}

#pragma mark - Setter & Getter.

- (void)setTorchMode:(AVCaptureTorchMode)torchMode {
    
    _torchMode = torchMode;
    
    if (_inputDevice && [_captureDevice hasTorch]) {
        
        [_captureDevice lockForConfiguration:nil];
        [_captureDevice setTorchMode:torchMode];
        [_captureDevice unlockForConfiguration];
    }
}

@end
