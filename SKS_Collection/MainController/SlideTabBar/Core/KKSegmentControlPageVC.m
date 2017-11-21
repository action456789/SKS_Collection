//
//  KKSegmentControlPageVC.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/11/21.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "KKSegmentControlPageVC.h"
#import "CommonMacro.h"
#import "KKSlideTabBarBaseLayout.h"
#import "KKSegmentControlPlaceholdVC.h"
#import "Masonry.h"

@interface KKSegmentControlPageVC () <UIScrollViewDelegate>
{
    UIView          *_containerView;
    UIScrollView    *_scrollView;
    NSUInteger      _itemCount;
    NSMutableArray<__kindof UIViewController *>  *_controllers;
}
@property (nonatomic, assign) NSUInteger currentPage;

@end

@implementation KKSegmentControlPageVC

- (instancetype)initWithItemCount:(NSInteger)count controllers:(NSMutableArray *)controllers {
    if (self = [super init]) {
        _controllers = [NSMutableArray array];
        _currentPage = -1;
        _itemCount = count;
        _realtimePage = controllers == nil;
        [self _createSubViewsWithControllers:controllers];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self autoScrollBottomScrollViewFromIndex:-1 toIndex:0 animate:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self _autoLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%f", _itemCount * _scrollView.frame.size.width);
    NSLog(@"%@", NSStringFromCGRect(_scrollView.frame));
    _scrollView.contentSize = CGSizeMake(_itemCount * _scrollView.frame.size.width, 0);
    
}

- (void)_createSubViewsWithControllers:(NSMutableArray *)controllers {
    _containerView = [UIView new];
    _containerView.backgroundColor = kSTBColorWithHex(kSTBBottomBgColor);
    [self.view addSubview:_containerView];
    
    _scrollView = [UIScrollView new];
    _scrollView.showsHorizontalScrollIndicator = YES;
    _scrollView.backgroundColor = kSTBColorWithHex(kSTBBottomBgColor);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    [_containerView addSubview:_scrollView];
    
    [self _addControllerViewsWithController:controllers];
}

- (void)_addControllerViewsWithController:(NSMutableArray *)controllers {
    for (int i=0; i<controllers.count; i++) {
        UIViewController *vc = controllers[i];
        [self _addControllerAtIndex:i withController:vc];
    }
}

- (void)_addControllerAtIndex:(NSUInteger)index withController:(UIViewController *)controller {
    [_controllers insertObject:controller atIndex:index];
    [_scrollView addSubview:controller.view];
    [controller.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.mas_equalTo(_scrollView);
        make.left.mas_equalTo(_scrollView.mas_left).offset(index*STB_SCREEN_WIDTH);
    }];
}

- (void)_replaceControllerAtIndex:(NSUInteger)index withController:(UIViewController *)controller {
    UIViewController *vc = _controllers[index];
    [_controllers replaceObjectAtIndex:index withObject:controller];
    [vc.view removeFromSuperview];
    [_scrollView addSubview:controller.view];
    [controller.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.mas_equalTo(_scrollView);
        make.left.mas_equalTo(_scrollView.mas_left).offset(index*STB_SCREEN_WIDTH);
    }];
}

- (void)updateControllerFromIndex:(NSUInteger)from toIndex:(NSUInteger)to withController:(UIViewController *)controller {
    NSInteger count = _controllers.count;
    if (to == count) { // first
        [self _addControllerAtIndex:to withController:controller];
        
    } else if (to < count) {
        BOOL sameKindOfObject = [_controllers[to] isKindOfClass:[KKSegmentControlPlaceholdVC class]];
        if (self.realtimePage || sameKindOfObject) {
            [self _replaceControllerAtIndex:to withController:controller];
        }
    } else {// jump
        for (NSUInteger i=from+1; i<to; i++) {
            KKSegmentControlPlaceholdVC *placeholdController = [[KKSegmentControlPlaceholdVC alloc] init];
            [self _addControllerAtIndex:i withController:placeholdController];
        }
        [self updateControllerFromIndex:from toIndex:to withController:controller];
    }
}

- (void)_autoLayoutSubviews {
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_containerView);
    }];
}

- (void)autoScrollBottomScrollViewFromIndex:(NSUInteger)from
                                    toIndex:(NSUInteger)to
                                    animate:(BOOL)animate {
    CGFloat x = to * STB_SCREEN_WIDTH;
    CGFloat y = _scrollView.frame.origin.y;
    [_scrollView setContentOffset:CGPointMake(x, y) animated:animate];
}

@synthesize currentPage = _currentPage;
- (NSUInteger)currentPage {
    return _scrollView.contentOffset.x / STB_SCREEN_WIDTH;
}

#pragma mark setter

- (void)setCurrentPage:(NSUInteger)currentPage {
    [self setCurrentPage:currentPage withAnimate:YES];
}

- (void)setCurrentPage:(NSUInteger)currentPage withAnimate:(BOOL)animate {
    [self autoScrollBottomScrollViewFromIndex:_currentPage toIndex:currentPage animate:animate];
    
    if (_currentPage != currentPage) {
        if ([self.delegate respondsToSelector:@selector(segmentControlPageVC:pageChangedFromIndex:toIndex:)]) {
            [self.delegate segmentControlPageVC:self pageChangedFromIndex:_currentPage toIndex:currentPage];
        }
    }

    _currentPage = currentPage;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.currentPage = page;
}

@end
