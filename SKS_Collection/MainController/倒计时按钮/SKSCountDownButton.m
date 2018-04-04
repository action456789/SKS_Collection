//
//  SKSCountDownButton.m
//  KsCollection
//
//  Created by KeSen on 6/28/16.
//  Copyright © 2016 KeSen. All rights reserved.
//

#import "SKSCountDownButton.h"
#import "NSTimer+BlockSupurt.h"

@interface SKSCountDownButton()

@end

@implementation SKSCountDownButton {
    NSTimer           *_timer;
    NSString          *_titleForNormal;
    
    NSTimeInterval    _enterBackgroudTime; // 进入后台持续的时间

    NSTimeInterval    _restTime; // 剩下的时间
    
    BOOL _isRunning; // 正在倒计时
}

- (instancetype)initWithTimeLenth:(NSTimeInterval)timeLenth
                     clickdHandle:(TouchUpInsideBlock)handle {
    if(self = [super init]) {
        _timeLength = timeLenth > 0 ? timeLenth : 60;
        [self addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _clickHandle = [handle copy];
        
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _enterBackgroudTime = 0;
    _restTime = 0;
    [self addNotification];
}

- (void)dealloc {
    [self invalidateTimer];
    [self removeNotification];
}

- (void)invalidateTimer {
    if(_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive)
                                                 name: UIApplicationWillResignActiveNotification
                                               object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationWillResignActive {
    _enterBackgroudTime = CACurrentMediaTime();
    [self invalidateTimer];
}

- (void)applicationDidBecomeActive {
    if(_restTime == self.timeLength) {
        return;
    }
    CFTimeInterval duration = CACurrentMediaTime() - _enterBackgroudTime;
    if (duration < _restTime) {
        [self invalidateTimer];
        [self _startTimerWithDuraion:(_restTime - duration)];
    } else {
        [self reset];
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

- (void)btnClicked:(SKSCountDownButton *)sender {
    if (_clickHandle) {
        _clickHandle(sender);
    }
}

- (void)startCountDown {
    self.userInteractionEnabled = NO;
    _titleForNormal = [self titleForState:UIControlStateNormal];
    
    [self setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)self.timeLength] forState:UIControlStateNormal];
    
    [self _startTimerWithDuraion:self.timeLength];
}

- (void)_startTimerWithDuraion:(NSTimeInterval)duration {
    _restTime = duration;
    __block NSString *title = @"";
    
    NSString *t = [NSString stringWithFormat:@"%lu", (unsigned long)_restTime];
    [self setTitle:t forState:UIControlStateNormal];
    
    _timer = [NSTimer sks_scheduledTimerInCommonModesWithTimeInterval:1.0f repeats:YES block:^{
        self->_restTime--;
        title = [NSString stringWithFormat:@"%lu", (unsigned long)self->_restTime];
        
        if (self->_restTime < 0) {
            [self reset];
        } else {
            [self setTitle:title forState:UIControlStateNormal];
            self.userInteractionEnabled = NO;
        }
    }];
}

- (void)reset {
    _restTime = self.timeLength;
    [self setTitle:_titleForNormal forState:UIControlStateNormal];
    self.userInteractionEnabled = YES;
    [_timer invalidate];
}

@end
