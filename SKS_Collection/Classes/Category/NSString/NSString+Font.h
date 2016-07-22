//
//  NSString+KS.h
//  iFanPhoto
//
//  Created by kesen on 14/12/1.
//  Copyright (c) 2014年 柯森. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Font)

/**
 *  去除字符串首尾空格
 */
- (NSString *)trim;

/**
 *  返回字符串所占用的尺寸
 *
 *  @param CGSize 限制字符串所占的宽高，传入 CGSizeMake(MAXFLOAT, MAXFLOAT) 表示不限制范围
 *
 *  @return 字符串占据的范围
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
