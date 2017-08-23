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
}

- (instancetype)initWithTimeLenth:(NSTimeInterval)timeLenth clickdHandle:(TouchUpInsideBlock)handle
{
    if(self = [super init]) {
        _timeLength = timeLenth > 0 ? timeLenth : 60;
        [self addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _clickHandle = [handle copy];
    }
    return self;
}

- (void)dealloc
{
    if(_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - getter, setter

- (void)setTimeLength:(NSTimeInterval)timeLength {
    _timeLength = timeLength < 0 ? 60 : timeLength;
}

- (void)setClickHandle:(TouchUpInsideBlock)clickHandle {
    _clickHandle = [clickHandle copy];
    
    [self addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - private method

- (void)btnClicked:(SKSCountDownButton *)sender
{
    if (_clickHandle) {
        _clickHandle(sender);
    }
}

- (void)startCountDown {
    self.userInteractionEnabled = NO;
    _titleForNormal = [self titleForState:UIControlStateNormal];
    
    [self setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)self.timeLength] forState:UIControlStateNormal];
    
    [self _startTimer];
}

- (void)_startTimer
{
    __block NSInteger timeLeft = self.timeLength;
    __block NSString *title = @"";
    
    _timer = [NSTimer sks_scheduledTimerInCommonModesWithTimeInterval:1.0f repeats:YES block:^{
        timeLeft--;
        title = [NSString stringWithFormat:@"%lu", (unsigned long)timeLeft];
        
        if (timeLeft < 0) {
            [self setTitle:_titleForNormal forState:UIControlStateNormal];
            self.userInteractionEnabled = YES;
            [_timer invalidate];
        } else {
            [self setTitle:title forState:UIControlStateNormal];
            self.userInteractionEnabled = NO;
        }
    }];
}

@end
