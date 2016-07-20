//
//  SKSCountDownButton.h
//  KsCollection
//
//  Created by KeSen on 6/28/16.
//  Copyright © 2016 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKSCountDownButton : UIButton

typedef void (^SKSCountDownButtonClickedHandle)(void);

- (instancetype)initWithTimeLenth:(NSTimeInterval)timeLenth clickdHandle:(SKSCountDownButtonClickedHandle)handle;

@end
