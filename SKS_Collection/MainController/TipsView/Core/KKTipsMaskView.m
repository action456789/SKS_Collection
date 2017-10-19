//
//  TipsMaskView.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/6/26.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "KKTipsMaskView.h"

@implementation KKTipsMaskView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.hidden == NO) {
        return [super hitTest:point withEvent:event];
    } else {
        UIView *hitView = [super hitTest:point withEvent:event];
        if(hitView == self) {
            return nil;
        }
        return hitView;
    }

}

@end
