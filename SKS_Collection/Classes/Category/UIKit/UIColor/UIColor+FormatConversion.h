//
//  UIColor+FormatConversion.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/25.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FormatConversion)

/**
 Provide some method for `UIColor` to convert color between
 RGB,HSB,HSL,CMYK and Hex.
 
 | Color space | Meaning                                |
 |-------------|----------------------------------------|
 | RGB *       | Red, Green, Blue                       |
 | HSB(HSV) *  | Hue, Saturation, Brightness (Value)    |
 | HSL         | Hue, Saturation, Lightness             |
 | CMYK        | Cyan, Magenta, Yellow, Black           |
 
 Apple use RGB & HSB default.
 
 All the value in this category is float number in the range `0.0` to `1.0`.
 Values below `0.0` are interpreted as `0.0`,
 and values above `1.0` are interpreted as `1.0`.
 
 If you want convert color between more color space (CIEXYZ,Lab,YUV...),
 see https://github.com/ibireme/yy_color_convertor
 */

// CMYK
// CMYK 印刷四色模式是彩色印刷时采用的一种套色模式，利用色料的三原色混色原理，加上黑色油墨，共计四种颜色混合叠加，形成所谓“全彩印刷”。
// C：Cyan = 青色，又称为‘天蓝色’或是‘湛蓝’M：Magenta = 品红色，又称为‘洋红色’；Y：Yellow = 黄色；K：Key Plate(blacK) = 定位套版色（黑色）
// 它和RGB相比有一个很大的不同：RGB模式是一种发光的色彩模式，你在一间黑暗的房间内仍然可以看见屏幕上的内容；
// CMYK是一种依靠反光的色彩模式，我们是怎样阅读报纸的内容呢？是由阳光或灯光照射到报纸上，再反射到我们的眼中，才看到内容。它需要有外界光源，如果你在黑暗房间内是无法阅读报纸的。

// HSL
// HSL 色相(Hue)、饱和度(Saturation)、明度(Lightness)三个颜色通道
// 在 HSL 模式下，每种 HSL 成分都可使用从 0到 255的值。（其中L是从黑（0）到白（255）渐变）

// HSB、HSV
// HSB又称HSV，H(hues)表示色相，S(saturation)表示饱和度，B（brightness）
// HSB模式中S和B呈现的数值越高，饱和度明度越高，页面色彩强烈艳丽，对视觉刺激是迅速的，醒目的效果，但不易于长时间的观看。

extern void kk_RGB2HSL(CGFloat r, CGFloat g, CGFloat b,
                       CGFloat *h, CGFloat *s, CGFloat *l);

extern void kk_HSL2RGB(CGFloat h, CGFloat s, CGFloat l,
                       CGFloat *r, CGFloat *g, CGFloat *b);

extern void kk_RGB2HSB(CGFloat r, CGFloat g, CGFloat b,
                       CGFloat *h, CGFloat *s, CGFloat *v);

extern void kk_HSB2RGB(CGFloat h, CGFloat s, CGFloat v,
                       CGFloat *r, CGFloat *g, CGFloat *b);

extern void kk_RGB2CMYK(CGFloat r, CGFloat g, CGFloat b,
                        CGFloat *c, CGFloat *m, CGFloat *y, CGFloat *k);

extern void kk_CMYK2RGB(CGFloat c, CGFloat m, CGFloat y, CGFloat k,
                        CGFloat *r, CGFloat *g, CGFloat *b);

extern void kk_HSB2HSL(CGFloat h, CGFloat s, CGFloat b,
                       CGFloat *hh, CGFloat *ss, CGFloat *ll);

extern void kk_HSL2HSB(CGFloat h, CGFloat s, CGFloat l,
                       CGFloat *hh, CGFloat *ss, CGFloat *bb);

extern BOOL kk_hexStrToRGBA(NSString *str, CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a);

@end
