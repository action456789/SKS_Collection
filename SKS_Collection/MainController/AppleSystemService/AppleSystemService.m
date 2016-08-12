//
//  AppleSystemService.m
//  SKS_Collection
//
//  Created by KeSen on 8/12/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "AppleSystemService.h"

@implementation AppleSystemService

+ (UIImage *)launchImage
{
    
    UIImage *launchImage = nil;
    
    NSString *viewOrientation = nil;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        viewOrientation = @"Landscape";
    } else {
        viewOrientation = @"Portrait";
    }
    
    NSArray *imagesDictionary = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDictionary) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        CGSize viewSize = [UIScreen mainScreen].bounds.size;
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }
    
    return launchImage;
}

@end
