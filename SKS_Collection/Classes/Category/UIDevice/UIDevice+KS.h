//
//  UIDevice+KS.h
//  KsCollection
//
//  Created by KeSen on 16/3/4.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (KS)

+ (BOOL)isOperatingSystemAtLeastVersion:(NSInteger)majorVersion
                           minorVersion:(NSInteger)minorVersion
                           patchVersion:(NSInteger)patchVersion;


@end
