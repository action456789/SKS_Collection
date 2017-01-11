//
//  NSString+Regular.h
//  KsCollection
//
//  Created by KeSen on 16/3/4.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regular)

- (BOOL)isQQ;
- (BOOL)isPhoneNumber;
- (BOOL)isIPAddress;
- (BOOL)isDigitsOfCount:(NSInteger)count;

@end
