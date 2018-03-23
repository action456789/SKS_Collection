//
//  KKTextField.m
//  RICISmartSwift
//
//  Created by sen.ke on 2018/2/6.
//  Copyright © 2018年 ke sen. All rights reserved.
//

#import "KKTextField.h"
#import "UITextField+placeholder.h"
#import "UITextField+InputRestrictions.h"
#import "CommonMacro.h"
#import "NSString+Regular.h"

@interface KKTextFieldTarget: NSObject <UITextFieldDelegate>

- (instancetype)initWithTextField:(KKTextField *)textField;
@property (nonatomic, weak) KKTextField *textField;

@end

@implementation KKTextFieldTarget

- (instancetype)initWithTextField:(KKTextField *)textField
{
    self = [super init];
    if (self) {
        self.textField = textField;
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self.textField addTarget:self
                       action:@selector(textFieldDidChanged)
             forControlEvents:UIControlEventEditingChanged];
}

// 限制字数
-(void)textFieldDidChanged {
    if (self == nil) {return;}

    __strong typeof(self) strongSelf = self;
    
    [strongSelf.textField kk_restrictMaxInputCount:strongSelf.textField.maxLenth];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 当输入符合规则和退格键时允许改变输入框
    if (string.kk_isNotContainSpecialCharacters || [string isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}

@end

@implementation KKTextField {
    KKTextFieldTarget *_target;
}

#define kPlaceholderFont [UIFont systemFontOfSize:14]
#define kPlaceholderFontColor kColorWithHex(0xe6e6e5)
#define kDefaultMaxLenth 120

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)dealloc {
    _target = nil;
}

- (void)commonInit {
    // 设置占位符的颜色
    [self kk_setPlaceholderFont:kPlaceholderFont];
    [self kk_setPlaceholderTextColor:kPlaceholderFontColor];
    
    _maxLenth = kDefaultMaxLenth;
    _isSpecailCharacterInputEnable = NO;
    
    _target = [[KKTextFieldTarget alloc] initWithTextField:self];
    self.delegate = _target;
}

@end
