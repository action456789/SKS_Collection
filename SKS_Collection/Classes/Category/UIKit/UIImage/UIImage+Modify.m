//
//  UIImage+Modify.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/25.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "UIImage+Modify.h"
#import "YYCGUtiilites.h"

@implementation UIImage (Modify)

- (UIImage *)kk_reduceBrightness {
    CIImage *beginImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
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
    
    CGImageRelease(cgimg);
    return newImg;
}

+ (UIImage *)kk_resizedImageWithName:(NSString *)name
{
    return [self kk_resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)kk_resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

- (void)drawInRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode clipsToBounds:(BOOL)clips{
    CGRect drawRect = YYCGRectFitWithContentMode(rect, self.size, contentMode);
    if (drawRect.size.width == 0 || drawRect.size.height == 0) return;
    if (clips) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (context) {
            CGContextSaveGState(context);
            CGContextAddRect(context, rect);
            CGContextClip(context);
            [self drawInRect:drawRect];
            CGContextRestoreGState(context);
        }
    } else {
        [self drawInRect:drawRect];
    }
}

- (UIImage *)kk_imageByResizeToSize:(CGSize)size {
    if (size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)kk_imageByResizeToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode {
    if (size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height) withContentMode:contentMode clipsToBounds:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 按照你想要的比例去缩放图片
- (UIImage *)kk_scaleToWidth:(CGFloat)width {
    // 如果传入的宽度比当前宽度还要大,就直接返回
    if (width > self.size.width) {
        return  self;
    }
    
    // 计算缩放之后的高度
    CGFloat height = (width / self.size.width) * self.size.height;
    CGRect rect = CGRectMake(0, 0, width, height);
    
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:rect];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
