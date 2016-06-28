//
//  NSString+Regular.h
//  KsCollection
//
//  Created by KeSen on 16/3/4.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KS_Regular)
/*-------------------------------正则表达式------------------------*/
- (BOOL)isQQ;
- (BOOL)isPhoneNumber;
- (BOOL)isIPAddress;
/*---------------------------------------------------------------*/
@end
