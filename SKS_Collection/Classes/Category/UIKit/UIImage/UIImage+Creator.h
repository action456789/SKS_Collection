//
//  UIImage+Creator.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/25.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Creator)

/**
 *  截屏
 *
 *  @param view 需要截屏的视图, 为空时是最屏幕最顶层 view
 *  @param size 需要截取的尺寸，为 CGSizeZero 时，截取整个 View
 *
 */
+ (instancetype)kk_imageWithCaptureView:(UIView *)view size:(CGSize)size;


/**
 Create and return a pure color image with the given color and size.
 
 @param color  The color.
 @param size   New image's type.
 */
+ (nullable UIImage *)kk_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 Create and return an image with custom draw code.
 
 @param size      The image size.
 @param drawBlock The draw block.
 
 @return The new image.
 */
+ (nullable UIImage *)kk_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock;

@end

NS_ASSUME_NONNULL_END
