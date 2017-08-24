//
//  NSString+Encode.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/24.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encode)

/**
 Returns an NSString for base64 encoded.
 */
- (nullable NSString *)kk_base64EncodedString;

- (NSString *_Nullable)kk_encodedString;

- (NSString *_Nullable)kk_decodedString;

@end
