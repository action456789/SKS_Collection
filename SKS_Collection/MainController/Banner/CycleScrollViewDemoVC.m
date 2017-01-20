//
//  CycleScrollViewDemoVC.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/12.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "CycleScrollViewDemoVC.h"
#import "SDCycleScrollView.h"
#import "CommonMacro.h"

@interface CycleScrollViewDemoVC () <SDCycleScrollViewDelegate>

@end

@implementation CycleScrollViewDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    UIImage *placeholdImage = [UIImage imageNamed:@"zlBanner"];
    
    NSArray *imagesGroup = @[[UIImage imageNamed:@"xgzxBannerMNJY"]
                             , [UIImage imageNamed:@"gpjn_banner2"]
                             , [UIImage imageNamed:@"comment_icon"]
                             , [UIImage imageNamed:@"zlBanner"]];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 250) imageNamesGroup:imagesGroup];
    
    // 网络加载图片的轮播器
//    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) delegate:self placeholderImage:placeholdImage];
//    cycleScrollView.imageURLStringsGroup = imagesGroup;
    
    cycleScrollView.delegate = self;
    
    [self.view addSubview:cycleScrollView];
}

#pragma mark - SDCycleScrollView Delegate

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%s, %ld", __func__, (long)index);
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    NSLog(@"%s, %ld", __func__, (long)index);
}

@end
