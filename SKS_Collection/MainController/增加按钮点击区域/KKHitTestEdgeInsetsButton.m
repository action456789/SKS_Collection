//
//  HitTestEdgeInsetsButton.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/11.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "KKHitTestEdgeInsetsButton.h"

@implementation KKHitTestEdgeInsetsButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) return nil;
    
    if (![self pointInside:point withEvent:event]) return nil;
    
    NSInteger count = self.subviews.count;
    
    for (NSInteger i = count - 1; i >= 0; i--) {
        UIView *childView = self.subviews[i];
        CGPoint childPoint = [self convertPoint:point toView:childView];
        UIView *fitView = [childView hitTest:childPoint withEvent:event];

        if (fitView) {
            return fitView;
        }
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGRect hitFrame = CGRectZero;
    
    if (self.padding > 0) {
        CGFloat x = self.bounds.origin.x - self.padding;
        CGFloat y = self.bounds.origin.y - self.padding;
        CGFloat w = self.bounds.size.width + 2 * self.padding;
        CGFloat h = self.bounds.size.height + 2 * self.padding;
        
        hitFrame = CGRectMake(x, y, w, h);
        
    } else {
        hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.hitTestEdgeInsets);
    }
    
    if (CGRectContainsPoint(hitFrame, point)) {
        return YES;
    }
    
    return NO;
}

@end
