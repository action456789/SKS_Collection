//
//  UIImage+QRCode.h
//  RICISmartSwift
//
//  Created by sen.ke on 2017/12/21.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCode)

NS_ASSUME_NONNULL_BEGIN

typedef void (^KKQrCodeResultBlock)(UIImage * image);

/**
 生成二维码图片
 
 @param qrCodeString 二维码包含的字符串
 @param imageSize 二维码图片大小
 @param logoImage 二维码中间logo图片，可以为空
 @return 二维码图片
 */
+ (UIImage *)kk_QRCodeImageFromString:(NSString *)qrCodeString imageSize:(CGSize)imageSize logoImage:(UIImage * _Nullable)logoImage;


/**
 生成二维码图片, logo 从 URL 中加载

 @param qrCodeString 二维码包含的字符串
 @param imageSize 二维码图片大小
 @param logoURL 二维码中间logo图片 url，可以为空
 @param result 生成的二维码图片回调
 */
+ (void)kk_QRCodeImageFromString:(NSString *)qrCodeString
                       imageSize:(CGSize)imageSize
                         logoURL:(NSString * _Nullable)logoURL
                          result:(KKQrCodeResultBlock _Nullable)result;

/**
 给图片添加 logo
 
 @param logoImage logo图片
 @param logoRect logo在原图片中的位置
 @return 添加logo后的图片
 */
- (UIImage *)kk_imageWithLogo:(UIImage *)logoImage logoRect:(CGRect)logoRect;

@end

NS_ASSUME_NONNULL_END
