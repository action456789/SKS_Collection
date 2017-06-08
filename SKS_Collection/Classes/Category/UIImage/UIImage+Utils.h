//
//  UIImage+Tool.h
//  KSTools
//
//  Created by KeSen on 15/9/11.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//  使用示例参见

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

/**
 *  返回一张降低了亮度的图片
 */
- (UIImage *)reduceBrightness;

/**
 *  获取圆形带边框图片
 *
 *  @param name   图片的名称
 *  @param borderWidth 圆环的宽度
 *  @param borderColor  圆环的颜色
 *
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  截屏
 *
 *  @param view 需要截屏的视图, 为空时是最屏幕最顶层 view
 *  @param size 需要截取的尺寸，为 CGSizeZero 时，截取整个 View
 *
 */
+ (instancetype)imageWithCaptureView:(UIView *)view size:(CGSize)size;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

// 根据颜色创建图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
