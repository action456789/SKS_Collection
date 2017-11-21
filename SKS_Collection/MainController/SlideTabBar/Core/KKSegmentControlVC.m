//
//  KKSegmentControlVC.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/11/21.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "KKSegmentControlVC.h"
#import "KKSegmentControlHeadVC.h"
#import "KKSegmentControlPageVC.h"
#import "KKSegmentControlBaseLayout.h"

#import "Masonry.h"

@interface KKSegmentControlVC () <KKSegmentControlPageVCDelegate, KKSegmentControlHeadVCDelegate>

@property (nonatomic, strong) KKSegmentControlHeadVC *headVC;
@property (nonatomic, strong) KKSegmentControlPageVC *pageVC;

@end

@implementation KKSegmentControlVC {
    NSMutableArray<NSString *> *_titles;
    NSCache<NSNumber *, __kindof UIViewController *> *_cache;
}

- (instancetype)initWithItemTitles:(NSMutableArray *)itemTitles
                       controllers:(NSMutableArray *)controllers
                            layout:(KKSegmentControlBaseLayout *)layout {
    if (self = [super init]) {
        _headVC = [[KKSegmentControlHeadVC alloc] initWithItemTitles:itemTitles layout:layout];
        _headVC.delegate = self;
        [self.view addSubview:_headVC.view];
        [self addChildViewController:_headVC];
        
        _pageVC = [[KKSegmentControlPageVC alloc] initWithItemCount:itemTitles.count controllers:controllers];
        _pageVC.delegate = self;
        [_pageVC setCurrentPage:0 withAnimate:NO];
        [self.view addSubview:_pageVC.view];
        [self addChildViewController:_pageVC];
    }
    return self;
}

- (instancetype)initWithItemTitles:(NSMutableArray *)itemTitles
                            layout:(KKSegmentControlBaseLayout *)layout {
    return [self initWithItemTitles:itemTitles controllers:nil layout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // gesture back
    [_pageVC.scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [_cache removeAllObjects];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.headVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.width.mas_equalTo(@(300));
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(@(kSTBTopViewHeight));
    }];
    
    [self.pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headVC.view.mas_bottom);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
}

#pragma mark KKSegmentControlPageVC delegate

- (void)segmentControlPageVC:(KKSegmentControlPageVC *)vc
        pageChangedFromIndex:(NSUInteger)from
                     toIndex:(NSUInteger)to
{
    NSLog(@"%ld, %ld", (unsigned long)from, (unsigned long)to);
    
    [self.headVC autoScrollItemsScrollViewFromIndex:from toIndex:to animate:YES];
    if (!self.pageVC.realtimePage) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIViewController *controller = [_cache objectForKey:@(to)];
        if (!controller) {
            controller = [self.delegate segmentControlVC:self viewControllerForPageAtIndex:to];
            controller.view.frame = self.view.frame;
            [_cache setObject:controller forKey:@(to)];
        }
        [self.pageVC updateControllerFromIndex:from toIndex:to withController:controller];
    });
}

#pragma mark KKSegmentControlHeadVC delegate

- (void)segmentControlHeadVC:(KKSegmentControlHeadVC *)vc
        itemChangedFromIndex:(NSUInteger)from
                     toIndex:(NSUInteger)to
{
    NSLog(@"%lu, %lu", (unsigned long)from, to);
    [self.pageVC autoScrollBottomScrollViewFromIndex:from toIndex:to animate:YES];
}

@end
