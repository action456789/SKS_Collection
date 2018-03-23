//
//  KKTextField.h
//  RICISmartSwift
//
//  Created by sen.ke on 2018/2/6.
//  Copyright © 2018年 ke sen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKTextField : UITextField

// 可以输入的最大字符长度，默认为 150，中文占 2 个字符，英文占一个
@property (nonatomic, assign) NSUInteger maxLenth;

// 是否允许输入特殊字符，包括表情等，默认为不允许
@property (nonatomic, assign) BOOL isSpecailCharacterInputEnable;

@end
