//
//  UIImage+Tool.m
//  KSTools
//
//  Created by KeSen on 15/9/11.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "UIImage+KS.h"

@implementation UIImage (KS)

/**
 *  返回一张降低了亮度的图片
 */
+ (UIImage *)reduceImageBrightnessWithImage:(UIImage *)image {
    
    CIImage *beginImage = [CIImage imageWithCGImage:image.CGImage];
    
    CIFilter *filter    = [CIFilter filterWithName:@"CIColorControls"];
    
    [filter setValue:beginImage forKey:kCIInputImageKey];
    
    //  饱和度      0---2
    //        [filter setValue:[NSNumber numberWithFloat:0.5] forKey:@"inputSaturation"];
    //  对比度 -11  0---4
    //        [filter setValue:[NSNumber numberWithFloat:1] forKey:@"inputContrast"];
    
    //  亮度  10   -1---1
    [filter setValue:[NSNumber numberWithFloat:-0.5] forKey:@"inputBrightness"];
    
    // 得到过滤后的图片
    CIImage *outputImage = [filter outputImage];
    
    // 转换图片, 创建基于GPU的CIContext对象
    CIContext *context = [CIContext contextWithOptions: nil];
    CGImageRef cgimg   = [context createCGImage:outputImage fromRect:[beginImage extent]];
    UIImage *newImg    = [UIImage imageWithCGImage:cgimg];
    
    // 释放C对象
    CGImageRelease(cgimg);
    
    return newImg;
}

/**
 *  截屏
 *
 *  @param view 需要截屏的视图
 *
 */
+ (instancetype)imageWithCaptureView:(UIView *)view
{
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 渲染控制器view的图层到上下文
    // 图层只能用渲染不能用draw
    [view.layer renderInContext:ctx];
    
    // 获取截屏图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  获取圆形带边框图片
 *
 *  @param name   图片的名称
 *  @param borderWidth 圆环的宽度
 *  @param borderColor  圆环的颜色
 *
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
{
    // 1.加载原图
    UIImage *oldImage = [UIImage imageNamed:name];
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

// 根据颜色创建图片
+ (UIImage *)createImageFromColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
