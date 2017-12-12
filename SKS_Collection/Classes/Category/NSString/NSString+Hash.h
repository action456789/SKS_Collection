//
//  NSString+Hash.h
//
//  Created by Tom Corwine on 5/30/12..
//

#import <Foundation/Foundation.h>

@interface NSString (Hash)

@property (readonly) NSString *kk_md5String;
@property (readonly) NSString *kk_sha1String;
@property (readonly) NSString *kk_sha256String;
@property (readonly) NSString *kk_sha512String;

- (NSString *)kk_hmacSHA1StringWithKey:(NSString *)key;
- (NSString *)kk_hmacSHA256StringWithKey:(NSString *)key;
- (NSString *)kk_hmacSHA512StringWithKey:(NSString *)key;

@end
