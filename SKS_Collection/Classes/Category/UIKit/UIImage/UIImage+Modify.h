//
//  UIImage+Modify.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/25.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Modify)

/**
 *  返回一张降低了亮度的图片
 */
- (UIImage *)kk_reduceBrightness;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)kk_resizedImageWithName:(NSString *)name;
+ (UIImage *)kk_resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

/**
 Returns a new image which is scaled from this image.
 The image will be stretched as needed.
 
 @param size  The new size to be scaled, values should be positive.
 
 @return      The new image with the given size.
 */
- (nullable UIImage *)kk_imageByResizeToSize:(CGSize)size;

/**
 Returns a new image which is scaled from this image.
 The image content will be changed with thencontentMode.
 
 @param size        The new size to be scaled, values should be positive.
 
 @param contentMode The content mode for image content.
 
 @return The new image with the given size.
 */
- (nullable UIImage *)kk_imageByResizeToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;

- (UIImage *)kk_scaleToWidth:(CGFloat)width;

// 将UIImage转为字节数据
- (unsigned char *)kk_toBytes;

/**
 @param data 从字节数据中返回UIImage
 @param w 原始图片数据的宽度
 @param h 原始图片数据的高度
 @return 新的的图片
 */
+ (UIImage *)kk_fromBytes:(unsigned char *)data originImageW:(CGFloat)w originImageH:(CGFloat)h;

@end

NS_ASSUME_NONNULL_END
