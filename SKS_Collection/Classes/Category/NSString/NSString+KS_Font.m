//
//  NSString+KS.m
//  iFanPhoto
//
//  Created by kesen on 14/12/1.
//  Copyright (c) 2014年 柯森. All rights reserved.
//

#import "NSString+KS_Font.h"

@implementation NSString (Font)

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

// 返回字符串所占用的尺寸
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    // NSStringDrawingUsesLineFragmentOrigin 整个文本将以每行组成的矩形为单位计算整个文本的尺寸
    // NSStringDrawingUsesFontLeading
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options: NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}



@end
