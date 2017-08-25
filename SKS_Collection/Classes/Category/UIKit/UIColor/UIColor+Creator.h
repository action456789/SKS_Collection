//
//  UIColor+Creating.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/25.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Creator)

#pragma mark - Create a UIColor Object
///=============================================================================
/// @name Creating a UIColor Object
///=============================================================================

// 返回随机颜色
+ (instancetype _Nullable)kk_randomColor;

/**
 Creates and returns a color object using the specified opacity
 and HSL color space component values.
 
 @param hue        The hue component of the color object in the HSL color space,
 specified as a value from 0.0 to 1.0.
 
 @param saturation The saturation component of the color object in the HSL color space,
 specified as a value from 0.0 to 1.0.
 
 @param lightness  The lightness component of the color object in the HSL color space,
 specified as a value from 0.0 to 1.0.
 
 @param alpha      The opacity value of the color object,
 specified as a value from 0.0 to 1.0.
 
 @return           The color object. The color information represented by this
 object is in the device RGB colorspace.
 */
+ (instancetype _Nullable)kk_colorWithHue:(CGFloat)hue
                        saturation:(CGFloat)saturation
                         lightness:(CGFloat)lightness
                             alpha:(CGFloat)alpha;

/**
 Creates and returns a color object using the specified opacity
 and CMYK color space component values.
 
 @param cyan    The cyan component of the color object in the CMYK color space,
 specified as a value from 0.0 to 1.0.
 
 @param magenta The magenta component of the color object in the CMYK color space,
 specified as a value from 0.0 to 1.0.
 
 @param yellow  The yellow component of the color object in the CMYK color space,
 specified as a value from 0.0 to 1.0.
 
 @param black   The black component of the color object in the CMYK color space,
 specified as a value from 0.0 to 1.0.
 
 @param alpha   The opacity value of the color object,
 specified as a value from 0.0 to 1.0.
 
 @return        The color object. The color information represented by this
 object is in the device RGB colorspace.
 */
+ (instancetype _Nullable)kk_colorWithCyan:(CGFloat)cyan
                                   magenta:(CGFloat)magenta
                                    yellow:(CGFloat)yellow
                                     black:(CGFloat)black
                                     alpha:(CGFloat)alpha;

/**
 Creates and returns a color object using the hex RGB color values.
 
 @param rgbValue  The rgb value such as 0x66ccff.
 
 @return          The color object. The color information represented by this
 object is in the device RGB colorspace.
 */
+ (instancetype _Nullable)kk_colorWithRGB:(uint32_t)rgbValue;

/**
 Creates and returns a color object using the hex RGBA color values.
 
 @param rgbaValue  The rgb value such as 0x66ccffff.
 
 @return           The color object. The color information represented by this
 object is in the device RGB colorspace.
 */
+ (instancetype _Nullable)kk_colorWithRGBA:(uint32_t)rgbaValue;

/**
 Creates and returns a color object using the specified opacity and RGB hex value.
 
 @param rgbValue  The rgb value such as 0x66CCFF.
 
 @param alpha     The opacity value of the color object,
 specified as a value from 0.0 to 1.0.
 
 @return          The color object. The color information represented by this
 object is in the device RGB colorspace.
 */
+ (instancetype _Nullable)kk_colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;

/**
 Creates and returns a color object from hex string.
 
 @discussion:
 Valid format: #RGB #RGBA #RRGGBB #RRGGBBAA 0xRGB ...
 The `#` or "0x" sign is not required.
 The alpha will be set to 1.0 if there is no alpha component.
 It will return nil when an error occurs in parsing.
 
 Example: @"0xF0F", @"66ccff", @"#66CCFF88"
 
 @param hexStr  The hex string value for the new color.
 
 @return        An UIColor object from string, or nil if an error occurs.
 */
+ (instancetype _Nullable)kk_colorWithHexString:(NSString *_Nullable)hexStr;

/**
 Creates and returns a color object by add new color.
 
 @param add        the color added
 
 @param blendMode  add color blend mode
 */
- (instancetype _Nullable)kk_colorByAddColor:(UIColor *_Nullable)add blendMode:(CGBlendMode)blendMode;

/**
 Creates and returns a color object by change components.
 
 @param hueDelta         the hue change delta specified as a value
 from -1.0 to 1.0. 0 means no change.
 
 @param saturationDelta  the saturation change delta specified as a value
 from -1.0 to 1.0. 0 means no change.
 
 @param brightnessDelta  the brightness change delta specified as a value
 from -1.0 to 1.0. 0 means no change.
 
 @param alphaDelta       the alpha change delta specified as a value
 from -1.0 to 1.0. 0 means no change.
 */
- (instancetype _Nullable )kk_colorByChangeHue:(CGFloat)hueDelta
                                    saturation:(CGFloat)saturationDelta
                                    brightness:(CGFloat)brightnessDelta
                                         alpha:(CGFloat)alphaDelta;

@end
