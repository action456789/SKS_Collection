//
//  ShimmerDemeController.m
//  SKS_Collection
//
//  Created by KeSen on 7/26/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "ShimmerDemeController.h"
#import "FBShimmeringView.h"

@implementation ShimmerDemeController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor blackColor];
    
    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:self.view.bounds];
    shimmeringView.shimmeringAnimationOpacity  = 1.f;
    shimmeringView.shimmeringBeginFadeDuration = 0.4;
    shimmeringView.shimmeringOpacity           = 0.3f;
    [self.view addSubview:shimmeringView];
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:shimmeringView.bounds];
    loadingLabel.text = NSLocalizedString(@"Shimmer", nil);
    loadingLabel.textColor = [UIColor cyanColor];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.font = [UIFont fontWithName:@"Heiti SC" size:60];
    loadingLabel.backgroundColor  = [UIColor clearColor];
    shimmeringView.contentView = loadingLabel;
    
    // Start shimmering.
    shimmeringView.shimmering = YES;
}

@end
