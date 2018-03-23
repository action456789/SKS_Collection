//
//  NSString+SubString.m
//  RICISmartSwift
//
//  Created by sen.ke on 2018/3/22.
//  Copyright © 2018年 ke sen. All rights reserved.
//

#import "NSString+SubString.h"

@implementation NSString (SubString)

/**
 *  获得 kMaxLength长度的字符
 */
- (NSString *)kk_subStringForMaxNumber:(NSInteger)maxNumber {
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* data = [self dataUsingEncoding:encoding];
    NSInteger length = [data length];
    if (length > maxNumber) {
        NSData *data1 = [data subdataWithRange:NSMakeRange(0, maxNumber)];
        NSString *content = [[NSString alloc] initWithData:data1 encoding:encoding];//【注意4】：当截取kMaxLength长度字符时把中文字符截断返回的content会是nil
        if (!content || content.length == 0) {
            data1 = [data subdataWithRange:NSMakeRange(0, maxNumber - 1)];
            content =  [[NSString alloc] initWithData:data1 encoding:encoding];
        }
        return content;
    }
    return nil;
}

@end
