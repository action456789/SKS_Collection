//
//  KKSegmentControlVC.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/11/21.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "KKSegmentControlVC.h"
#import "KKSegmentControlBaseLayout.h"
#import <Masonry.h>

@interface KKSegmentControlVC() <KKSegmentControlPageVCDelegate, KKSegmentControlHeadVCDelegate>
    
@end

@implementation KKSegmentControlVC {
    NSMutableArray<NSString *> *_titles;
    NSCache<NSNumber *, __kindof UIViewController *> *_cache;
}
    
- (instancetype)initWithItemTitles:(NSMutableArray *)itemTitles
                            layout:(KKSegmentControlBaseLayout *)layout {
    return [self initWithItemTitles:itemTitles controllers:nil layout:layout];
}
    
- (instancetype)initWithItemTitles:(NSMutableArray *)itemTitles
                       controllers:(NSMutableArray *)controllers
                            layout:(KKSegmentControlBaseLayout *)layout {
    if (self = [super init]) {
        _titles = itemTitles;
        
        _headVC = [[KKSegmentControlHeadVC alloc] initWithItemTitles:itemTitles layout:layout];
        _headVC.delegate = self;
        [self.view addSubview:_headVC.view];
        [self addChildViewController:_headVC];
        
        _pageVC = [[KKSegmentControlPageVC alloc] initWithPageCount:itemTitles.count
                                                        controllers:controllers];
        _pageVC.delegate = self;
        [_pageVC setCurrentPage:0 isUserOperate:NO];
        [self.view addSubview:_pageVC.view];
        [self addChildViewController:_pageVC];
        
        _cache = [[NSCache alloc] init];
        
        [self autoLayoutSubviews];
    }
    return self;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 解决 gesture back 冲突
    [_pageVC.scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [_cache removeAllObjects];
}
    
- (void)autoLayoutSubviews {
    CGFloat h = _headVC.layout.config.headerViewHeight;
    CGFloat w = _headVC.layout.config.headerViewWidth;
    [self.headVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(@(h));
        make.width.mas_equalTo(@(w));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headVC.view.mas_bottom);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
    
    // 只有一个时，不显示头部
    if (_titles.count == 1) {
        self.headVC.view.hidden = YES;
        [self.pageVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headVC.view.mas_bottom).offset(-h);
        }];
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }
}
    
#pragma mark KKSegmentControlPageVC delegate
    
- (void)segmentControlPageVC:(KKSegmentControlPageVC *)vc
        pageChangedFromIndex:(NSUInteger)from
                     toIndex:(NSUInteger)to
               isUserOperate:(BOOL)isUserOperate
    {
        if (isUserOperate) {
            [self.headVC autoScrollItemsScrollViewFromIndex:from toIndex:to animate:YES];
        }
        
        if (!self.pageVC.realtimePage) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *controller = [self->_cache objectForKey:@(to)];
            if (!controller) {
                controller = [self.delegate segmentControlVC:self viewControllerForPageAtIndex:to];
                if (controller) {
                    [self->_cache setObject:controller forKey:@(to)];
                }
            }
            [self.pageVC updateControllerFromIndex:from toIndex:to withController:controller];
        });
    }
    
#pragma mark KKSegmentControlHeadVC delegate
    
- (void)segmentControlHeadVC:(KKSegmentControlHeadVC *)vc
        itemChangedFromIndex:(NSUInteger)from
                     toIndex:(NSUInteger)to
    {
        [self.pageVC setCurrentPage:to isUserOperate:NO];
    }
    
    @end
