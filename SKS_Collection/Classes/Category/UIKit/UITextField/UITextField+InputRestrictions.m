//
//  UITextField+InputRestrictions.m
//  RICISmartSwift
//
//  Created by sen.ke on 2018/3/22.
//  Copyright © 2018年 ke sen. All rights reserved.
//

#import "UITextField+InputRestrictions.h"
#import "NSString+Regular.h"
#import "NSString+SubString.h"

@implementation UITextField (InputRestrictions)

- (void)kk_restrictMaxInputCount:(NSUInteger)maxCount {
    NSString *toBeString = self.text;
    
    if (![toBeString kk_isNotContainSpecialCharactersAndSpace]) {
        self.text = [toBeString kk_removeEmoji];
        return;
    }
    
    NSString *lang = [[self textInputMode] primaryLanguage]; // 获取当前键盘输入模式
    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入,第三方输入法（搜狗）所有模式下都会显示“zh-Hans”
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if(!position) {
            NSString *getStr = [toBeString kk_subStringForMaxNumber:maxCount];
            if(getStr && getStr.length > 0) {
                self.text = getStr;
                
                NSLog(@"%@", self.text);
            }
        }
    } else {
        NSString *getStr = [toBeString kk_subStringForMaxNumber:maxCount];
        if(getStr && getStr.length > 0) {
            self.text= getStr;
            NSLog(@"%@",self.text);
        }
    }
}

@end
