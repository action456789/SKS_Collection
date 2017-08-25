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



@end

NS_ASSUME_NONNULL_END
