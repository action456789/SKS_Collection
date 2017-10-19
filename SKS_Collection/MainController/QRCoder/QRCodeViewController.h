//
//  QRCodeViewController.h
//  SKS_Collection
//
//  Created by KeSen on 7/25/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QRCodeViewController;

@protocol QRCodeViewControllerDelegate <NSObject>

@optional
- (void)qrCodeResultMacAddress:(NSString *)mac;
- (void)qrCodeResultHttpAddress:(NSString *)url;
- (void)qrCodeResultInvalidateCode;

@end


@interface QRCodeViewController : UIViewController

@property (nonatomic,weak) id<QRCodeViewControllerDelegate> delegate;

@end
