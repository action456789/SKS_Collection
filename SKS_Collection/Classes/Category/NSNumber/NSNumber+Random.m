//
//  NSNumber+Random.m
//  RICISmartSwift
//
//  Created by sen.ke on 08/12/2017.
//  Copyright © 2017 ke sen. All rights reserved.
//

#import "NSNumber+Random.h"

@implementation NSNumber (Random)

/// 获取一个随机整数，范围在[from,to），包括from，不包括to
+ (instancetype)kk_randomNumber:(int)from to:(int)to {
    //+1,result is [from to]; else is [from, to)!!!!!!!
    int value = (int)(from + (arc4random() % (to - from + 1)));
    return @(value);
}

@end
