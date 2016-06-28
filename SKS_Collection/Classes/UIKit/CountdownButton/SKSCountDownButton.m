//
//  SKSCountDownButton.m
//  KsCollection
//
//  Created by KeSen on 6/28/16.
//  Copyright © 2016 KeSen. All rights reserved.
//

#import "SKSCountDownButton.h"
#import <objc/runtime.h>

@implementation SKSCountDownButton {
    dispatch_source_t _timer;
    NSString          *_titleForNormal;
    NSInteger    _updateSecond;
}

+ (void)load
{
    Method originalMethod = class_getInstanceMethod([self class],
                                                    @selector(sendAction:to:forEvent:));
    Method swappedMethod = class_getInstanceMethod([self class],
                                                   @selector(p_sendAction:to:forEvent:));
    method_exchangeImplementations(originalMethod, swappedMethod);
    
}

- (void)setSecond:(NSInteger)second
{
    _second = second > 0 ? second : 60;
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
}

- (void)p_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    _titleForNormal = [self titleForState:UIControlStateNormal];
    self.userInteractionEnabled = NO;
    _updateSecond = _second + 1;
    [self setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)_second] forState:UIControlStateNormal];
    [self startTimer];
    [self p_sendAction:action to:target forEvent:event];
}

- (void)startTimer
{
    NSTimeInterval interval = 1.0f;
    NSTimeInterval delay = 0.0f;
    [self setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)_updateSecond] forState:UIControlStateNormal];
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, delay), interval * NSEC_PER_SEC, 1.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        --_updateSecond;
        [self setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)_updateSecond] forState:UIControlStateNormal];
        if (_updateSecond < 0) {
            self.userInteractionEnabled = YES;
            [self setTitle:_titleForNormal forState:UIControlStateNormal];
            dispatch_suspend(_timer);
        }
    });
    dispatch_resume(_timer);
}

- (void)dealloc
{
    dispatch_cancel(_timer);
}

@end
