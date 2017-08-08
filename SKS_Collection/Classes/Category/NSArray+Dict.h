//
//  NSArray+Dict.h
//  RICISmartSwift
//
//  Created by sen.ke on 2017/8/3.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Dict)

typedef NSMutableArray<NSArray<NSDictionary*>*> KKDictArray;
- (KKDictArray *)splipWithKey:(NSString *)key;

@end
