//
//  UIImage+QRCode.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/12/21.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "UIImage+QRCode.h"
#import "UIImage+CoreImage.h"
#import <SDWebImage/SDWebImageManager.h>

@implementation UIImage (QRCode)

+ (UIImage *)kk_QRCodeImageFromString:(NSString *)qrCodeString
                            imageSize:(CGSize)imageSize
                            logoImage:(UIImage * _Nullable)logoImage {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [qrCodeString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];//通过kvo方式给一个字符串，生成二维码
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];//设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    CIImage *outputCIImage = [filter outputImage];//拿到二维码图片
    UIImage *outputUIImage = [UIImage kk_imageFormCIImage:outputCIImage imageSize:imageSize];
    
    // 给二维码加 logo 图
    // 把logo图画到生成的二维码图片上，注意尺寸不要太大（最大不超过二维码图片的%30），太大会造成扫不出来
    if (logoImage) {
        CGRect logoRect = [self _logoRectFromImageSize:imageSize];
        UIImage *newPic = [outputUIImage kk_imageWithLogo:logoImage logoRect:logoRect];
        return newPic;
    } else {
        return outputUIImage;
    }
}

+ (CGRect)_logoRectFromImageSize:(CGSize)imageSize {
    CGFloat logoW = imageSize.width * 0.3;
    CGFloat logoH = imageSize.height * 0.3;
    CGFloat logoX = (imageSize.width - logoW) * 0.5;
    CGFloat logoY = (imageSize.height - logoH) * 0.5;
    CGRect logoRect = CGRectMake(logoX, logoY, logoW, logoH);
    return logoRect;
}

+ (void)kk_QRCodeImageFromString:(NSString *)qrCodeString
                       imageSize:(CGSize)imageSize
                         logoURL:(NSString * _Nullable)logoURL
                          result:(KKQrCodeResultBlock _Nullable)result {
    __block UIImage *qrImage = [self kk_QRCodeImageFromString:qrCodeString imageSize:imageSize logoImage:nil];
    
    NSURL *url = [NSURL URLWithString:logoURL];
    if (url == nil) {
        result(qrImage);
        return;
    }
    
    [SDWebImageManager.sharedManager.imageDownloader downloadImageWithURL:url options:1 progress:nil completed:^(UIImage * _Nullable logo, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        UIImage *logedQRImage = nil;
        if (logo) {
            CGRect rect = [self _logoRectFromImageSize:imageSize];
            logedQRImage = [qrImage kk_imageWithLogo:logo logoRect:rect];
            result(logedQRImage);
        } else {
            result(qrImage);
        }
    }];
}

/**
 给图片添加 logo

 @param logoImage logo图片
 @param logoRect logo在原图片中的位置
 @return 添加logo后的图片
 */
- (UIImage *)kk_imageWithLogo:(UIImage *)logoImage logoRect:(CGRect)logoRect {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0 , self.size.width, self.size.height)];
    [logoImage drawInRect:logoRect];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}

@end
