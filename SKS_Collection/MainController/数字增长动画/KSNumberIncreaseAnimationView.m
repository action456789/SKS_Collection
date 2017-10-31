//
//  KSNumberIncreaseAnimationView.m
//  CheckMardAnimation
//
//  Created by KeSen on 16/1/29.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "KSNumberIncreaseAnimationView.h"
#import <pop/POP.h>

@interface KSNumberIncreaseAnimationView()

@property (nonatomic, assign) CGFloat initNumber;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIFont *numberLabelFont;

@end

#define kDefaultFont [UIFont systemFontOfSize:15]

@implementation KSNumberIncreaseAnimationView

#pragma mark - lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _numberLabel = [[UILabel alloc] initWithFrame:frame];
        _numberLabel.font = self.numberLabelFont;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_numberLabel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame number:(CGFloat)number {
    self = [self initWithFrame:frame];
    _numberLabel.text = [NSString stringWithFormat:@"%.2f", number];
    return self;
}

#pragma mark - public method

- (void)showFromNumber:(CGFloat)from toNumber:(CGFloat)to WithDuration:(CGFloat)duration delay:(CGFloat)delay {
    
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"prop" initializer:^(POPMutableAnimatableProperty *prop) {
        
        prop.readBlock = ^(id obj, CGFloat values[]) {
            self.numberLabel.text = [NSString stringWithFormat:@".2%f", from];
        };
        
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            self.numberLabel.text = [NSString stringWithFormat:@"%.2f", (CGFloat)values[0]];
        };
        
        prop.threshold = 0.001;
    }];
    
    POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];
    anBasic.property = prop; // 自定义属性
    anBasic.fromValue = @(from);
    anBasic.toValue = @(to);
    anBasic.duration = duration;
    anBasic.beginTime = CACurrentMediaTime() + delay;
    
    [self.numberLabel pop_addAnimation:anBasic forKey:@"countdown"];
}

- (void)hide {
    
}

#pragma mark - getter

- (UIFont *)numberLabelFont {
    return _numberLabelFont == nil ? kDefaultFont :_numberLabelFont;
}

@end
