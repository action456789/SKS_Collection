//
//  AppleSystemServiceViewController.m
//  SKS_Collection
//
//  Created by KeSen on 8/12/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "AppleSystemServiceViewController.h"
#import "UIDevice+KS.h"

@implementation AppleSystemServiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    BOOL b = [UIDevice isOperatingSystemAtLeastVersion:9 minorVersion:3 patchVersion:6];
    NSLog(@"%d", b);
}

@end
