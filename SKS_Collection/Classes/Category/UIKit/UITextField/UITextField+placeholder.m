//
//  UITextField+placeholder.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/11/9.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "UITextField+placeholder.h"

@implementation UITextField (placeholder)

- (void)kk_setPlaceholderTextColor:(UIColor *)color {
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)kk_setPlaceholderFont:(UIFont *)font {
    [self setValue:font forKeyPath:@"_placeholderLabel.font"];
}

@end
