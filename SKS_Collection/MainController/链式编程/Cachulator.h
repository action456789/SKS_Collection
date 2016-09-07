//
//  Cachulator.h
//  SKS_Collection
//
//  Created by KeSen on 9/7/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Cachulator;

typedef Cachulator* (^CachulatorBlock)(CGFloat num);

@interface Cachulator : NSObject

@property (nonatomic, assign) CGFloat result;

- (CachulatorBlock)add;
- (CachulatorBlock)minus;
- (CachulatorBlock)multiply;
- (CachulatorBlock)divide;

@end
