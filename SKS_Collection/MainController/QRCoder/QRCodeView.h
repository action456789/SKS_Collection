//
//  QRCodeView.h
//  SKS_Collection
//
//  Created by KeSen on 7/25/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class QRCodeView;

@protocol QRCodeViewDelegate <NSObject>

- (void)QRCodeView:(QRCodeView *)view scanedResultString:(NSString *)result;

@end

@interface QRCodeView : UIView

@property (nonatomic) AVCaptureTorchMode torchMode;

@property (nonatomic,weak) id<QRCodeViewDelegate> delegate;

- (void)startReading;
- (void)stopReading;

@end
