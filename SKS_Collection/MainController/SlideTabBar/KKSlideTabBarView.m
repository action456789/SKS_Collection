//
//  FsSlideTabBarView.m
//  tvcontroller
//
//  Created by KeSen on 16/4/14.
//  Copyright © 2016年 funshon. All rights reserved.
//

#import "KKSlideTabBarView.h"
#import <Masonry.h>
#import "UIColor+Hex.h"

static const CGFloat kTopViewHeight          = 40;
static const CGFloat kFirstItemLeftPadding   = 10;
static const CGFloat kLastItemRightPadding   = 10;
static const CGFloat kItemHorizontalSpace    = 15;
static const CGFloat kItemMoreWidth          = 0;
static const CGFloat kItemLineLeftOverWidtht = 5;
static const CGFloat kItemHeightRatio        = 0.9f;

static const CGFloat kItemFontSize           = 14;

static NSString *kBarBgColor      = @"#292e37";
static NSString *kBottomBgColor   = @"#1f232a";
static NSString *kItemLineBgColor = @"#ff7608";
static NSString *kItemButtonColor = @"#808080";

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface KKSlideTabBarView() <UIScrollViewDelegate>
@property (nonatomic, assign) CGFloat itemScrollViewContentW;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *itemStringWidths;
@property (nonatomic, assign) NSUInteger currentPage;
@end

@implementation KKSlideTabBarView {
    UIView          *_topContainerView;
    UIScrollView    *_itemsScrollView;
    UIButton        *_itemMore;
    UIView          *_itemLine;
    
    UIView          *_bottomContainerView;
    UIScrollView    *_bottomScrollView;
    
    UIButton        *_selectedItem;
    CGRect          _itemLinePreFrame;
    
    NSMutableArray<UIButton *>  *_itemButtons;
    NSMutableArray<UIButton *>  *_notNeedToSrollToCenterBtns;
    NSArray<NSString *>  *_itemTitles;
    NSMutableArray<__kindof UIViewController *>  *_controllers;
    
    // cache of delegete function
    struct {
        unsigned int didPageChangedHandle    : 1;
        unsigned int didItemMoreClickdHandle : 1;
    }_delegateFlags;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self configTabBar];
}

- (instancetype)initWithFrame:(CGRect)frame itemTitles:(NSMutableArray *)itemTitles controllers:(NSMutableArray *)controllers
{
    if (self = [super initWithFrame:frame]) {
        _itemTitles = itemTitles;
        _itemButtons = [NSMutableArray array];
        _controllers = [NSMutableArray array];
        _currentPage = -1;
        _realtimePage = controllers == nil;
        [self p_createTopSubViews];
        [self p_createBottomSubViewsWithControllers:controllers];
        [self p_autoLayoutSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame itemTitles:(NSMutableArray *)itemTitles
{
    self = [self initWithFrame:frame itemTitles:itemTitles controllers:nil];
    return self;
}

- (void)p_createTopSubViews
{
    _topContainerView = [[UIView alloc] init];
    _topContainerView.backgroundColor = [UIColor colorWithHexString:kBarBgColor];
    [self addSubview:_topContainerView];
    
    _itemsScrollView = [[UIScrollView alloc] init];
    _itemsScrollView.backgroundColor = [UIColor colorWithHexString:kBarBgColor];
    _itemsScrollView.showsHorizontalScrollIndicator = NO;
    _itemsScrollView.showsVerticalScrollIndicator = NO;
    _itemsScrollView.bounces = NO;
    _itemsScrollView.delegate = self;
    [_topContainerView addSubview:_itemsScrollView];
    
    [self p_createItems];
    
    _itemMore = [UIButton buttonWithType:UIButtonTypeCustom];
    [_itemMore setTitle:@"更多" forState:UIControlStateNormal];
    _itemMore.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_itemMore.titleLabel setFont:[UIFont systemFontOfSize:kItemFontSize]];
    [_itemMore setTitleColor:[UIColor colorWithHexString:kItemButtonColor] forState:UIControlStateNormal];
    [_itemMore setTitleColor:[UIColor colorWithHexString:kItemLineBgColor] forState:UIControlStateSelected];
    [_itemMore addTarget:self action:@selector(itemMoreClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_topContainerView addSubview:_itemMore];
    
    _itemLine = [UIView new];
    _itemLine.backgroundColor = [UIColor colorWithHexString:kItemLineBgColor];
    CGFloat w = [self.itemStringWidths[0] floatValue] + 2 * kItemLineLeftOverWidtht;
    CGFloat h = 2;
    CGFloat x = kFirstItemLeftPadding - kItemLineLeftOverWidtht;
    CGFloat y = kTopViewHeight * kItemHeightRatio;
    _itemLine.frame = CGRectMake(x, y, w, h);
    _itemLinePreFrame = _itemLine.frame;
    [_itemsScrollView addSubview:_itemLine];
}

- (void)p_createBottomSubViewsWithControllers:(NSMutableArray *)controllers
{
    _bottomContainerView = [UIView new];
    _bottomContainerView.backgroundColor = [UIColor colorWithHexString:kBottomBgColor];
    [self addSubview:_bottomContainerView];
    
    _bottomScrollView = [UIScrollView new];
    _bottomScrollView.showsHorizontalScrollIndicator = YES;
    _bottomScrollView.backgroundColor = [UIColor colorWithHexString:kBottomBgColor];
    _bottomScrollView.pagingEnabled = YES;
    _bottomScrollView.bounces = NO;
    _bottomScrollView.delegate = self;
    [_bottomContainerView addSubview:_bottomScrollView];
    
    [self p_addControllerViewsWithController:controllers];
}

- (void)p_autoLayoutSubviews
{
    [_topContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top).offset(44);
        make.height.mas_equalTo(@(kTopViewHeight));
    }];
    
    [_itemsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat widthOffset = -kItemMoreWidth;
        make.left.mas_equalTo(_topContainerView.mas_left);
        make.top.bottom.mas_equalTo(_topContainerView);
        make.width.mas_equalTo(_topContainerView.mas_width).offset(widthOffset);
    }];
    
    [_itemMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(_topContainerView);
        make.height.mas_equalTo(kItemHeightRatio * kTopViewHeight);
        make.width.mas_equalTo(kItemMoreWidth);
    }];
    
    [_bottomContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topContainerView.mas_bottom);
        make.left.right.mas_equalTo(_topContainerView);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    [_bottomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_bottomContainerView);
    }];
}

- (void)p_createItems
{
    __block CGFloat itemX = kFirstItemLeftPadding;
    
    [_itemTitles enumerateObjectsUsingBlock:^(NSString *titleString, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemButton setTitle:titleString forState:UIControlStateNormal];
        itemButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        itemButton.titleLabel.font = [UIFont systemFontOfSize:kItemFontSize];
        [itemButton setTitleColor:[UIColor colorWithHexString:kItemButtonColor] forState:UIControlStateNormal];
        [itemButton setTitleColor:[UIColor colorWithHexString:kItemLineBgColor] forState:UIControlStateSelected];
        [itemButton addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_itemsScrollView addSubview:itemButton];
        
        CGFloat titleStringW = [self.itemStringWidths[idx] floatValue];
        CGFloat x = itemX + idx * kItemHorizontalSpace;
        [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_itemsScrollView.mas_top);
            make.height.mas_equalTo(@(kTopViewHeight * kItemHeightRatio));
            make.left.mas_equalTo(_itemsScrollView.mas_left).offset(x);
            make.width.mas_equalTo(@(titleStringW));
        }];
        
        itemButton.tag = idx;
        [_itemButtons addObject:itemButton];
        itemX += titleStringW;
    }];
}

- (void)p_addControllerViewsWithController:(NSMutableArray *)controllers
{
    for (int i=0; i<controllers.count; i++) {
        UIViewController *vc = controllers[i];
        [self p_addControllerAtIndex:i withController:vc];
    }
}

- (void)p_addControllerAtIndex:(NSUInteger)index withController:(UIViewController *)controller
{
    [_controllers insertObject:controller atIndex:index];
    [_bottomScrollView addSubview:controller.view];
    [controller.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.mas_equalTo(_bottomScrollView);
        make.left.mas_equalTo(_bottomScrollView.mas_left).offset(index*SCREEN_WIDTH);
    }];
}

- (void)p_replaceControllerAtIndex:(NSUInteger)index withController:(UIViewController *)controller
{
    UIViewController *vc = _controllers[index];
    [_controllers replaceObjectAtIndex:index withObject:controller];
    [vc.view removeFromSuperview];
    [_bottomScrollView addSubview:controller.view];
    [controller.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.mas_equalTo(_bottomScrollView);
        make.left.mas_equalTo(_bottomScrollView.mas_left).offset(index*SCREEN_WIDTH);
    }];
}

- (void)itemPressed:(UIButton *)sender
{
    self.currentPage = sender.tag;
}

- (void)p_updateItemButtonWithButton:(UIButton *)button
{
    _selectedItem.selected = NO;
    button.selected = YES;
    _selectedItem = button;
}

- (void)p_updateItemLineWithButton:(UIButton *)button animate:(BOOL)animate
{
    
    CGFloat lineX = _itemLinePreFrame.origin.x;
    CGFloat lineY = _itemLinePreFrame.origin.y;
    CGFloat lineW = [self.itemStringWidths[button.tag] floatValue] + kItemLineLeftOverWidtht * 2;
    CGFloat lineH = _itemLinePreFrame.size.height;
    
    if (animate) {
        [UIView animateWithDuration:0.3f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
            if (button.center.x > 0) {
                _itemLine.frame = CGRectMake(lineX, lineY, lineW, lineH);
                CGPoint center = CGPointMake(button.center.x, _itemLine.center.y);
                _itemLine.center = center;
            } else {
                _itemLine.frame = CGRectMake(kFirstItemLeftPadding - kItemLineLeftOverWidtht, lineY, lineW, lineH);
            }
        } completion:nil];
    } else {
        if (button.center.x > 0) {
            _itemLine.frame = CGRectMake(lineX, lineY, lineW, lineH);
            CGPoint center = CGPointMake(button.center.x, _itemLine.center.y);
            _itemLine.center = center;
        } else {
            _itemLine.frame = CGRectMake(kFirstItemLeftPadding - kItemLineLeftOverWidtht, lineY, lineW, lineH);
        }
    }
    _itemLinePreFrame = _itemLine.frame;
}

- (void)p_autoScrollBottomScrollViewFromIndex:(NSUInteger)from toIndex:(NSUInteger)to animate:(BOOL)animate
{
    CGFloat x = to * SCREEN_WIDTH;
    CGFloat y = _bottomScrollView.frame.origin.y;
    [_bottomScrollView setContentOffset:CGPointMake(x, y) animated:animate];
}

- (void)p_autoScrollItemsScrollViewFromIndex:(NSUInteger)from toIndex:(NSUInteger)to animate:(BOOL)animate
{
    
    // 不滚动
    UIButton *lastBtn = _itemButtons.lastObject;
    if ((lastBtn.frame.origin.x + lastBtn.frame.size.width) < (SCREEN_WIDTH - kItemMoreWidth - kLastItemRightPadding)) {
        return;
    }
    
    UIButton *btnTo = _itemButtons[to];
    [self p_updateItemLineWithButton:btnTo animate:YES];
    [self p_updateItemButtonWithButton:btnTo];
    
    CGFloat screenCenterX = SCREEN_WIDTH * 0.5;
    CGFloat contentOffsetY = _itemsScrollView.contentOffset.y;
    CGFloat contentOffsetX = btnTo.center.x - screenCenterX;
    
    if (![_notNeedToSrollToCenterBtns containsObject:btnTo]) { // 滚动到屏幕中间
        if (btnTo.center.x > screenCenterX) {
            [_itemsScrollView setContentOffset:CGPointMake(contentOffsetX, contentOffsetY) animated:animate];
        } else {
            [_itemsScrollView setContentOffset:CGPointMake(0, contentOffsetY) animated:animate];
        }
    } else { // 滚动到屏幕最右边
        CGFloat tailX = lastBtn.frame.origin.x + lastBtn.frame.size.width + kLastItemRightPadding - (SCREEN_WIDTH - kItemMoreWidth);
        [_itemsScrollView setContentOffset:CGPointMake(tailX, contentOffsetY) animated:animate];
    }
}

- (void)itemMoreClicked:(UIButton *)sender
{
    if (_delegateFlags.didItemMoreClickdHandle) {
        [self.delegate slideTabBarView:self itemMoreClicked:sender];
    }
}

# pragma mark - getter

- (NSMutableArray *)itemStringWidths
{
    if (!_itemStringWidths) {
        _itemStringWidths = [NSMutableArray array];
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:kItemFontSize]};
        for (NSString *title in _itemTitles) {
            CGFloat w = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
            [_itemStringWidths addObject:@(ceil(w))];
        }
    }
    return _itemStringWidths;
}

- (CGFloat)itemScrollViewContentW
{
    _itemScrollViewContentW = 0;
    for (NSNumber *value in self.itemStringWidths) {
        _itemScrollViewContentW += [value floatValue];
    }
    _itemScrollViewContentW += (_itemTitles.count - 1) * kItemHorizontalSpace;
    return _itemScrollViewContentW;
}

@synthesize currentPage = _currentPage;

- (NSUInteger)currentPage
{
    return _bottomScrollView.contentOffset.x / SCREEN_WIDTH;
}

#pragma mark setter

- (void)setCurrentPage:(NSUInteger)currentPage
{
    [self setCurrentPage:currentPage withAnimate:YES];
}

- (void)setNavigationController:(UINavigationController *)navigationController
{
    _navigationController = navigationController;
    
    // gesture back
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 7.0) {
        [_bottomScrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    }
}

#pragma mark -other

- (void)setCurrentPage:(NSUInteger)currentPage withAnimate:(BOOL)animate
{
    UIButton *sender = _itemButtons[currentPage];
    [self p_updateItemButtonWithButton:sender];
    [self p_updateItemLineWithButton:sender animate:animate];
    
    if (_currentPage != currentPage) {
        [self p_autoScrollBottomScrollViewFromIndex:_currentPage toIndex:currentPage animate:animate];
        [self p_autoScrollItemsScrollViewFromIndex:_currentPage toIndex:currentPage animate:animate];
        
        if (_delegateFlags.didPageChangedHandle) {
            [self.delegate slideTabBarView:self pageChangedFromIndex:_currentPage toIndex:currentPage];
        }
    }
    _currentPage = currentPage;
}


- (void)configTabBar
{
    _itemsScrollView.contentSize = CGSizeMake(self.itemScrollViewContentW + SCREEN_WIDTH * 0.1, 0);
    _bottomScrollView.contentSize = CGSizeMake(_itemButtons.count * _bottomScrollView.frame.size.width, 0);
    [self p_createNotNeedToSrollToCenterBtns];
}

- (void)p_createNotNeedToSrollToCenterBtns
{
    if (_itemButtons.count == 0) {
        return;
    }
    
    UIButton *lastBtn = _itemButtons.lastObject;
    CGFloat tailMaxX = 0;
    CGFloat tailMinX = 0;
    if ((lastBtn.frame.origin.x + kLastItemRightPadding) > (SCREEN_WIDTH - kItemMoreWidth)) {
        tailMaxX = lastBtn.frame.origin.x + lastBtn.frame.size.width + kLastItemRightPadding;
        tailMinX = tailMaxX - (SCREEN_WIDTH * 0.5 - kItemMoreWidth);
    } else {
        tailMaxX = lastBtn.frame.origin.x + lastBtn.frame.size.width + kLastItemRightPadding;
        tailMinX = SCREEN_WIDTH * 0.5;
    }
    _notNeedToSrollToCenterBtns = [NSMutableArray array];
    for (UIButton *btn in _itemButtons) {
        if (btn.center.x > tailMinX && btn.center.x < tailMaxX) {
            [_notNeedToSrollToCenterBtns addObject:btn];
        }
    }
}

- (void)updateControllerFromIndex:(NSUInteger)from toIndex:(NSUInteger)to withController:(UIViewController *)controller
{
    if (!self.realtimePage) {
        return;
    }
    
    NSInteger count = _controllers.count;
    if (to == count) { // first
        [self p_addControllerAtIndex:to withController:controller];
        
    } else if (to < count) {
        BOOL sameKindOfObject = [_controllers[to] isKindOfClass:[FsPlaceholdViewController class]];
        if (sameKindOfObject) {
            [self p_replaceControllerAtIndex:to withController:controller];
        }
    } else {// jump
        for (NSUInteger i=from+1; i<to; i++) {
            FsPlaceholdViewController *placeholdController = [[FsPlaceholdViewController alloc] init];
            [self p_addControllerAtIndex:i withController:placeholdController];
        }
        [self updateControllerFromIndex:from toIndex:to withController:controller];
    }
}

- (void)setDelegate:(id<KKSlideTabBarViewDelegate>)delegate {
    _delegate = delegate;
    _delegateFlags.didPageChangedHandle = [self.delegate respondsToSelector:@selector(slideTabBarView:pageChangedFromIndex:toIndex:)];
    _delegateFlags.didItemMoreClickdHandle = [self.delegate respondsToSelector:@selector(itemMoreClicked:)];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _bottomScrollView) {
        int page = _bottomScrollView.contentOffset.x / _bottomScrollView.bounds.size.width;
        self.currentPage = page;
    }
}

@end

@implementation FsPlaceholdViewController

@end
