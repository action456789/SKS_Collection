//
//  SKSCountDownButton.m
//  KsCollection
//
//  Created by KeSen on 6/28/16.
//  Copyright © 2016 KeSen. All rights reserved.
//

#import "SKSCountDownButton.h"
#import "NSTimer+BlockSupurt.h"

@implementation SKSCountDownButton {
    NSTimer           *_timer;
    NSString          *_titleForNormal;
    NSTimeInterval    _second;
    SKSCountDownButtonClickedHandle  _clickedHandle;
}

- (instancetype)initWithTimeLenth:(NSTimeInterval)timeLenth clickdHandle:(SKSCountDownButtonClickedHandle)handle
{
    if(self = [super init]) {
        _second = timeLenth > 0 ? timeLenth : 60;
        [self addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
        _clickedHandle = [handle copy];
    }
    return self;
}

- (void)btnClicked
{
    self.userInteractionEnabled = NO;
    _titleForNormal = [self titleForState:UIControlStateNormal];
    [self setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)_second] forState:UIControlStateNormal];
    
    [self p_startTimer];
    
    if (_clickedHandle) {
        _clickedHandle();
    }
}

- (void)p_startTimer
{
    __block NSInteger timeLeft = _second;

    _timer = [NSTimer sks_scheduledTimerInCommonModesWithTimeInterval:1.0f repeats:YES block:^{
        timeLeft--;
        if (timeLeft < 0) {
            [self setTitle:_titleForNormal forState:UIControlStateNormal];
            self.userInteractionEnabled = YES;
            [_timer invalidate];
        } else {
            [self setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)timeLeft] forState:UIControlStateNormal];
            self.userInteractionEnabled = NO;
        }
    }];
}


- (void)dealloc
{
    if(_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
