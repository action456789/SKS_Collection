//
//  UILabel+NumberIncreaseAnim.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/9/5.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "UILabel+NumberIncreaseAnim.h"
#import <pop/POP.h>

@implementation UILabel (NumberIncreaseAnim)

- (void)kk_AnimateFromNumber:(CGFloat)from toNumber:(CGFloat)to WithDuration:(CGFloat)duration delay:(CGFloat)delay {
    
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"prop" initializer:^(POPMutableAnimatableProperty *prop) {
        
        prop.readBlock = ^(id obj, CGFloat values[]) {
            self.text = [NSString stringWithFormat:@"%.0f%%", from];
        };
        
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            self.text = [NSString stringWithFormat:@"%.0f%%", (CGFloat)values[0]];
        };
        
        prop.threshold = 0.001;
    }];
    
    POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];
    anBasic.property = prop; // 自定义属性
    anBasic.fromValue = @(from);
    anBasic.toValue = @(to);
    anBasic.duration = duration;
    anBasic.beginTime = CACurrentMediaTime() + delay;
    
    [self pop_addAnimation:anBasic forKey:@"countdown"];
}

@end
