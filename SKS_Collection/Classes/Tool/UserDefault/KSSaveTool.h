//
//  KSSaveTool.h
//  KSCollects
//
//  Created by KeSen on 15/10/9.
//  Copyright © 2015年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSSaveTool : NSObject

+ (void)setObject:(id)value forKey:(NSString *)defaultName;

+ (id)objectForKey:(NSString *)defaultName;

@end
