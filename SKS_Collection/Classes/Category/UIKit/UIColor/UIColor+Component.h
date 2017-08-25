//
//  UIColor+Component.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/25.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Component)

/**
 Returns the rgb value in hex.
 @return hex value of RGB,such as 0x66ccff.
 */
- (uint32_t)kk_rgbValue;

/**
 Returns the rgba value in hex.
 
 @return hex value of RGBA,such as 0x66ccffff.
 */
- (uint32_t)kk_rgbaValue;

/**
 Returns the color's RGB value as a hex string (lowercase).
 Such as @"0066cc".
 
 It will return nil when the color space is not RGB
 
 @return The color's value as a hex string.
 */
- (nullable NSString *)kk_hexString;

/**
 Returns the color's RGBA value as a hex string (lowercase).
 Such as @"0066ccff".
 
 It will return nil when the color space is not RGBA
 
 @return The color's value as a hex string.
 */
- (nullable NSString *)kk_hexStringWithAlpha;


///=============================================================================
/// @name Retrieving Color Information
///=============================================================================

/**
 Returns the components that make up the color in the HSL color space.
 
 @param hue         On return, the hue component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @param saturation  On return, the saturation component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @param lightness   On return, the lightness component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @param alpha       On return, the alpha component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @return            YES if the color could be converted, NO otherwise.
 */
- (BOOL)kk_getHue:(CGFloat *)hue
       saturation:(CGFloat *)saturation
        lightness:(CGFloat *)lightness
            alpha:(CGFloat *)alpha;

/**
 Returns the components that make up the color in the CMYK color space.
 
 @param cyan     On return, the cyan component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @param magenta  On return, the magenta component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @param yellow   On return, the yellow component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @param black    On return, the black component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @param alpha    On return, the alpha component of the color object,
 specified as a value between 0.0 and 1.0.
 
 @return         YES if the color could be converted, NO otherwise.
 */
- (BOOL)kk_getCyan:(CGFloat *)cyan
           magenta:(CGFloat *)magenta
            yellow:(CGFloat *)yellow
             black:(CGFloat *)black
             alpha:(CGFloat *)alpha;

/**
 The color's red component value in RGB color space.
 The value of this property is a float in the range `0.0` to `1.0`.
 */
@property (nonatomic, readonly) CGFloat kk_red;

/**
 The color's green component value in RGB color space.
 The value of this property is a float in the range `0.0` to `1.0`.
 */
@property (nonatomic, readonly) CGFloat kk_green;

/**
 The color's blue component value in RGB color space.
 The value of this property is a float in the range `0.0` to `1.0`.
 */
@property (nonatomic, readonly) CGFloat kk_blue;

/**
 The color's hue component value in HSB color space.
 The value of this property is a float in the range `0.0` to `1.0`.
 */
@property (nonatomic, readonly) CGFloat kk_hue;

/**
 The color's saturation component value in HSB color space.
 The value of this property is a float in the range `0.0` to `1.0`.
 */
@property (nonatomic, readonly) CGFloat kk_saturation;

/**
 The color's brightness component value in HSB color space.
 The value of this property is a float in the range `0.0` to `1.0`.
 */
@property (nonatomic, readonly) CGFloat kk_brightness;

/**
 The color's alpha component value.
 The value of this property is a float in the range `0.0` to `1.0`.
 */
@property (nonatomic, readonly) CGFloat kk_alpha;

/**
 The color's colorspace model.
 */
@property (nonatomic, readonly) CGColorSpaceModel kk_colorSpaceModel;

/**
 Readable colorspace string.
 */
@property (nullable, nonatomic, readonly) NSString *kk_colorSpaceString;


@end

NS_ASSUME_NONNULL_END
