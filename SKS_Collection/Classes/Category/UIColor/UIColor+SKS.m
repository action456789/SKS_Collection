//
//  UIColor+Hex.m
//  tvcontroller
//
//  Created by test on 15/10/26.
//  Copyright © 2015年 funshon. All rights reserved.
//

#import "UIColor+SKS.h"

@implementation UIColor (SKS)

+ (instancetype)colorWithHexString:(NSString *)color
{
    return [UIColor colorWithHexString:color alpha:1.0f];
}

+ (instancetype)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //remove whitespace and \n convert to uppercase;
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 7 characters
    if ([cString length] == 7 && [cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
        
        NSRange range = NSMakeRange(0, 2);
        NSString *redString = [cString substringWithRange:range];
        range.location = 2;
        NSString *greenString = [cString substringWithRange:range];
        range.location = 4;
        NSString *blueString = [cString substringWithRange:range];
        
        // Scan values
        unsigned int red, green, blue;
        [[NSScanner scannerWithString:redString] scanHexInt:&red];
        [[NSScanner scannerWithString:greenString] scanHexInt:&green];
        [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
        return [UIColor colorWithRed:((float)red / 255.0f) green:((float)green / 255.0f) blue:((float)blue / 255.0f) alpha:alpha];
    }
    else
    {
        return [UIColor clearColor];
    }
}

+ (instancetype)randomColor
{
    return [UIColor colorWithRed:arc4random_uniform(255.0f)/255.0f
                           green:arc4random_uniform(255.0f)/255.0f
                            blue:arc4random_uniform(255.0f)/255.0f
                           alpha:1];
}

@end
