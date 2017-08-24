//
//  NSArray+Plist.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/24.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - NSArray

@interface NSArray (Plist)
/**
 Creates and returns an array from a specified property list data.
 
 @param plist   A property list data whose root object is an array.
 @return A new array created from the binary plist data, or nil if an error occurs.
 */
+ (nullable NSArray *)kk_arrayWithPlistData:(NSData *_Nullable)plist;

/**
 Creates and returns an array from a specified property list xml string.
 
 @param plist   A property list xml string whose root object is an array.
 @return A new array created from the plist string, or nil if an error occurs.
 */
+ (nullable NSArray *)kk_arrayWithPlistString:(NSString *_Nullable)plist;

/**
 Serialize the array to a binary property list data.
 
 @return A binary plist data, or nil if an error occurs.
 */
- (nullable NSData *)kk_plistData;

/**
 Serialize the array to a xml property list string.
 
 @return A plist xml string, or nil if an error occurs.
 */
- (nullable NSString *)kk_plistString;

@end

#pragma mark - NSMutableArray

@interface NSMutableArray (Plist)

/**
 Creates and returns an array from a specified property list data.
 
 @param plist   A property list data whose root object is an array.
 @return A new array created from the binary plist data, or nil if an error occurs.
 */
+ (nullable NSMutableArray *)kk_arrayWithPlistData:(NSData *_Nonnull)plist;

/**
 Creates and returns an array from a specified property list xml string.
 
 @param plist   A property list xml string whose root object is an array.
 @return A new array created from the plist string, or nil if an error occurs.
 */
+ (nullable NSMutableArray *)kk_arrayWithPlistString:(NSString *_Nonnull)plist;

@end
