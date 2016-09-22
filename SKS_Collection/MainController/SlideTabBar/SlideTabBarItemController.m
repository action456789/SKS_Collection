//
//  SlideTabBarDemo.m
//  SKS_Collection
//
//  Created by KeSen on 7/18/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "SlideTabBarItemController.h"
#import "CommonMacro.h"

@interface SlideTabBarItemController()<UIScrollViewDelegate>

@end

@implementation SlideTabBarItemController
{
    UIScrollView *_scrollView;
    CGFloat _originalContentOffsetY;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight * 4);
        scrollView.alwaysBounceVertical = YES;
        scrollView.delegate = self;
        [self.view addSubview:scrollView];
        scrollView;
    });
    
    UILabel *lable = [[UILabel alloc] init];
    [self.view addSubview:lable];
    lable.text = @"我是label";
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _originalContentOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat delta = scrollView.contentOffset.y - _originalContentOffsetY;
    if (delta > 10) {
        [self.delegate scrollDown];
    } else if (delta < -10) {
        [self.delegate scrollUp];
    }
}

@end
