//
//  UIImage+CoreImage.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/12/21.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "UIImage+CoreImage.h"

@implementation UIImage (CoreImage)

+ (UIImage *)kk_imageFormCIImage:(CIImage *)image imageSize:(CGSize)imageSize
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scaleW = imageSize.width/CGRectGetWidth(extent);
    CGFloat scaleH = imageSize.height/CGRectGetHeight(extent);
    
    // 1. 创建bitmap
    size_t width = CGRectGetWidth(extent) * scaleW;
    size_t height = CGRectGetHeight(extent) * scaleH;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    // CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
    // width：图片宽度像素
    // height：图片高度像素
    // bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
    // bitmapInfo：指定的位图应该包含一个alpha通道。
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    // 缩放坐标系
    CGContextScaleCTM(bitmapRef, scaleW, scaleH);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

@end
