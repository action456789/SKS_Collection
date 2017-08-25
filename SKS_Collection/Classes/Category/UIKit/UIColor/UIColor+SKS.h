//
//  UIColor+Hex.h
//  tvcontroller
//
//  Created by test on 15/10/26.
//  Copyright © 2015年 funshon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(SKS)

// 由字符串返回颜色

+ (instancetype)colorWithHexString:(NSString *)color; 

/**
 * @param color: @“#123456” 
 */
+ (instancetype)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
