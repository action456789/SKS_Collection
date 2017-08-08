//
//  NSArray+Dict.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/8/3.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "NSArray+Dict.h"

@implementation NSArray (Dict)
/**
 *  字典数组，根据某个key值，切割成二维数组
 如字典
[{
     "AttrHex": 15855616,
     "ConditionGroup": 523442684
 },
 {
     "AttrHex": 524288,
     "ConditionGroup": 523442702
 },
 {
     "AttrHex": 50331655,
     "ConditionGroup": 523442702
 },
 {
     "AttrHex": 50393088,
     "ConditionGroup": 523442702
 }]
 
 按照 ConditionGroup 分割，结果为
 
[
    [
        {
            "AttrHex": 15855616,
            "ConditionGroup": 523442684
        }
    ],
    [
        {
            "AttrHex": 524288,
            "ConditionGroup": 523442702
        },
        {
            "AttrHex": 50331655,
            "ConditionGroup": 523442702
        },
        {
            "AttrHex": 50393088,
            "ConditionGroup": 523442702
        }
     ]
]
 
 */

- (KKDictArray *)splipWithKey:(NSString *)key {
    NSArray *array = [self valueForKeyPath:key];
    NSSet *set = [NSSet setWithArray:array];
    
    KKDictArray *splitArray = [NSMutableArray array];
    for (NSString *value in set) {
        NSMutableArray<NSDictionary *> *subArray = [NSMutableArray array];
        for (NSDictionary *dict in self) {
            if ([[dict objectForKey:key] isEqualToString:value]) {
                [subArray addObject:dict];
            }
        }
        [splitArray addObject:subArray];
    }
    
    return splitArray;
}
@end
