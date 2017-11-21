//
//  FsSlideTabBarView.m
//  tvcontroller
//
//  Created by KeSen on 16/4/14.
//  Copyright © 2016年 funshon. All rights reserved.
//

#import "KKSlideTabBarView.h"
#import "KKSlideTabBarLayoutAuto.h"
#import "KKSlideTabBarLayoutBisect.h"

@interface KKSlideTabBarView() <UIScrollViewDelegate>
@property (nonatomic, assign) CGFloat itemScrollViewContentW;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, strong) KKSegmentControlBaseLayout *layout;
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

- (instancetype)initWithFrame:(CGRect)frame
                   itemTitles:(NSMutableArray *)itemTitles
                  controllers:(NSMutableArray *)controllers
                       layout:(KKSegmentControlBaseLayout *)layout
{
    if (self = [super initWithFrame:frame]) {
        _itemTitles = itemTitles;
        _itemButtons = [NSMutableArray array];
        _controllers = [NSMutableArray array];
        _currentPage = -1;
        _realtimePage = controllers == nil;
        _layout = layout;

        [self _createTopSubViews];
        [self _createBottomSubViewsWithControllers:controllers];
        [self _autoLayoutSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                   itemTitles:(NSMutableArray *)itemTitles
                       layout:(KKSegmentControlBaseLayout *)layout
{
    self = [self initWithFrame:frame itemTitles:itemTitles controllers:nil layout:layout];
    return self;
}

- (void)_createTopSubViews
{
    _topContainerView = [[UIView alloc] init];
    _topContainerView.backgroundColor = kSTBColorWithHex(kSTBBarBgColor);
    [self addSubview:_topContainerView];
    
    _itemsScrollView = [[UIScrollView alloc] init];
    _itemsScrollView.backgroundColor = kSTBColorWithHex(kSTBBarBgColor);
    _itemsScrollView.showsHorizontalScrollIndicator = NO;
    _itemsScrollView.showsVerticalScrollIndicator = NO;
    _itemsScrollView.bounces = NO;
    _itemsScrollView.delegate = self;
    _itemsScrollView.scrollEnabled = self.layout.itemScrollViewScrollEnable;
    [_topContainerView addSubview:_itemsScrollView];
    
    [self _createItems];
    
    _itemMore = [UIButton buttonWithType:UIButtonTypeCustom];
    [_itemMore setTitle:@"更多" forState:UIControlStateNormal];
    _itemMore.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_itemMore.titleLabel setFont:[UIFont systemFontOfSize:kSTBItemFontSize]];
    [_itemMore setTitleColor:kSTBColorWithHex(kSTBItemFontNormalColor) forState:UIControlStateNormal];
    [_itemMore setTitleColor:kSTBColorWithHex(kSTBItemLineBgColor) forState:UIControlStateSelected];
    [_itemMore addTarget:self action:@selector(itemMoreClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_topContainerView addSubview:_itemMore];
    
    _itemLine = [UIView new];
    _itemLine.backgroundColor = kSTBColorWithHex(kSTBItemLineBgColor);
    CGFloat w = [self.layout lineWidthWithIndex:0];
    CGFloat h = 2;
    CGFloat x = kSTBFirstItemLeftPadding - kSTBItemLineLeftOverWidtht;
    CGFloat y = kSTBTopViewHeight * kSTBItemHeightRatio;
    _itemLine.frame = CGRectMake(x, y, w, h);
    _itemLinePreFrame = _itemLine.frame;
    [_itemsScrollView addSubview:_itemLine];
}

- (void)_createBottomSubViewsWithControllers:(NSMutableArray *)controllers
{
    _bottomContainerView = [UIView new];
    _bottomContainerView.backgroundColor = kSTBColorWithHex(kSTBBottomBgColor);
    [self addSubview:_bottomContainerView];
    
    _bottomScrollView = [UIScrollView new];
    _bottomScrollView.showsHorizontalScrollIndicator = YES;
    _bottomScrollView.backgroundColor = kSTBColorWithHex(kSTBBottomBgColor);
    _bottomScrollView.pagingEnabled = YES;
    _bottomScrollView.bounces = NO;
    _bottomScrollView.delegate = self;
    [_bottomContainerView addSubview:_bottomScrollView];
    
    [self _addControllerViewsWithController:controllers];
}

- (void)_autoLayoutSubviews
{
    [_topContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top).offset(44);
        make.height.mas_equalTo(@(kSTBTopViewHeight));
    }];
    
    [_itemsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat widthOffset = -kSTBItemMoreWidth;
        make.left.mas_equalTo(_topContainerView.mas_left);
        make.top.bottom.mas_equalTo(_topContainerView);
        make.width.mas_equalTo(_topContainerView.mas_width).offset(widthOffset);
    }];
    
    [_itemMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(_topContainerView);
        make.height.mas_equalTo(kSTBItemHeightRatio * kSTBTopViewHeight);
        make.width.mas_equalTo(kSTBItemMoreWidth);
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

- (void)_createItems
{
    [_itemTitles enumerateObjectsUsingBlock:^(NSString *titleString, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemButton addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [itemButton setTitle:_itemTitles[idx] forState:UIControlStateNormal];
        itemButton.tag = idx;
        
        [_itemsScrollView addSubview:itemButton];
        
        [_itemButtons addObject:itemButton];
    }];
    
    [self.layout layoutItemsViews:_itemButtons];
}

- (void)_addControllerViewsWithController:(NSMutableArray *)controllers
{
    for (int i=0; i<controllers.count; i++) {
        UIViewController *vc = controllers[i];
        [self _addControllerAtIndex:i withController:vc];
    }
}

- (void)_addControllerAtIndex:(NSUInteger)index withController:(UIViewController *)controller
{
    [_controllers insertObject:controller atIndex:index];
    [_bottomScrollView addSubview:controller.view];
    [controller.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.mas_equalTo(_bottomScrollView);
        make.left.mas_equalTo(_bottomScrollView.mas_left).offset(index*STB_SCREEN_WIDTH);
    }];
}

- (void)_replaceControllerAtIndex:(NSUInteger)index withController:(UIViewController *)controller
{
    UIViewController *vc = _controllers[index];
    [_controllers replaceObjectAtIndex:index withObject:controller];
    [vc.view removeFromSuperview];
    [_bottomScrollView addSubview:controller.view];
    [controller.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.mas_equalTo(_bottomScrollView);
        make.left.mas_equalTo(_bottomScrollView.mas_left).offset(index*STB_SCREEN_WIDTH);
    }];
}

- (void)itemPressed:(UIButton *)sender
{
    self.currentPage = sender.tag;
}

- (void)_updateItemButtonWithButton:(UIButton *)button
{
    _selectedItem.selected = NO;
    button.selected = YES;
    _selectedItem = button;
}

- (void)_updateItemLineWithButton:(UIButton *)button animate:(BOOL)animate
{
    CGFloat lineX = _itemLinePreFrame.origin.x;
    CGFloat lineY = _itemLinePreFrame.origin.y;
    CGFloat lineW = [self.layout lineWidthWithIndex:button.tag];
    CGFloat lineH = _itemLinePreFrame.size.height;
    
    if (animate) {
        [UIView animateWithDuration:0.3f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
            if (button.center.x > 0) {
                _itemLine.frame = CGRectMake(lineX, lineY, lineW, lineH);
                CGPoint center = CGPointMake(button.center.x, _itemLine.center.y);
                _itemLine.center = center;
            } else {
                _itemLine.frame = CGRectMake(kSTBFirstItemLeftPadding - kSTBItemLineLeftOverWidtht, lineY, lineW, lineH);
            }
        } completion:nil];
    } else {
        if (button.center.x > 0) {
            _itemLine.frame = CGRectMake(lineX, lineY, lineW, lineH);
            CGPoint center = CGPointMake(button.center.x, _itemLine.center.y);
            _itemLine.center = center;
        } else {
            _itemLine.frame = CGRectMake(kSTBFirstItemLeftPadding - kSTBItemLineLeftOverWidtht, lineY, lineW, lineH);
        }
    }
    _itemLinePreFrame = _itemLine.frame;
}

- (void)_autoScrollBottomScrollViewFromIndex:(NSUInteger)from toIndex:(NSUInteger)to animate:(BOOL)animate
{
    CGFloat x = to * STB_SCREEN_WIDTH;
    CGFloat y = _bottomScrollView.frame.origin.y;
    [_bottomScrollView setContentOffset:CGPointMake(x, y) animated:animate];
}

- (void)_autoScrollItemsScrollViewFromIndex:(NSUInteger)from toIndex:(NSUInteger)to animate:(BOOL)animate
{
    // 不滚动
    UIButton *lastBtn = _itemButtons.lastObject;
    if ((lastBtn.frame.origin.x + lastBtn.frame.size.width) < (STB_SCREEN_WIDTH - kSTBItemMoreWidth - kSTBLastItemRightPadding)) {
        return;
    }
    
    UIButton *btnTo = _itemButtons[to];
    [self _updateItemLineWithButton:btnTo animate:YES];
    [self _updateItemButtonWithButton:btnTo];
    
    CGFloat screenCenterX = STB_SCREEN_WIDTH * 0.5;
    CGFloat contentOffsetY = _itemsScrollView.contentOffset.y;
    CGFloat contentOffsetX = btnTo.center.x - screenCenterX;
    
    if (self.layout.itemScrollViewScrollEnable) {
        if (![_notNeedToSrollToCenterBtns containsObject:btnTo]) { // 滚动到屏幕中间
            if (btnTo.center.x > screenCenterX) {
                [_itemsScrollView setContentOffset:CGPointMake(contentOffsetX, contentOffsetY) animated:animate];
            } else {
                [_itemsScrollView setContentOffset:CGPointMake(0, contentOffsetY) animated:animate];
            }
        } else { // 滚动到屏幕最右边
            CGFloat tailX = lastBtn.frame.origin.x + lastBtn.frame.size.width + kSTBLastItemRightPadding - (STB_SCREEN_WIDTH - kSTBItemMoreWidth);
            [_itemsScrollView setContentOffset:CGPointMake(tailX, contentOffsetY) animated:animate];
        }
    }
}

- (void)itemMoreClicked:(UIButton *)sender
{
    if (_delegateFlags.didItemMoreClickdHandle) {
        [self.delegate slideTabBarView:self itemMoreClicked:sender];
    }
}

# pragma mark - getter

- (CGFloat)itemScrollViewContentW
{
    _itemScrollViewContentW = 0;
    for (NSNumber *value in self.layout.itemStringWidths) {
        _itemScrollViewContentW += [value floatValue];
    }
    _itemScrollViewContentW += (_itemTitles.count - 1) * kSTBItemHorizontalSpace;
    return _itemScrollViewContentW;
}

@synthesize currentPage = _currentPage;

- (NSUInteger)currentPage
{
    return _bottomScrollView.contentOffset.x / STB_SCREEN_WIDTH;
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
    [_bottomScrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
}

#pragma mark -other

- (void)setCurrentPage:(NSUInteger)currentPage withAnimate:(BOOL)animate
{
    UIButton *sender = _itemButtons[currentPage];
    [self _updateItemButtonWithButton:sender];
    [self _updateItemLineWithButton:sender animate:animate];
    
    if (_currentPage != currentPage) {
        [self _autoScrollBottomScrollViewFromIndex:_currentPage toIndex:currentPage animate:animate];
        [self _autoScrollItemsScrollViewFromIndex:_currentPage toIndex:currentPage animate:animate];
        
        if (_delegateFlags.didPageChangedHandle) {
            [self.delegate slideTabBarView:self pageChangedFromIndex:_currentPage toIndex:currentPage];
        }
    }
    _currentPage = currentPage;
}


- (void)configTabBar
{
    _itemsScrollView.contentSize = CGSizeMake(self.itemScrollViewContentW + STB_SCREEN_WIDTH * 0.1, 0);
    _bottomScrollView.contentSize = CGSizeMake(_itemButtons.count * _bottomScrollView.frame.size.width, 0);
    [self _createNotNeedToSrollToCenterBtns];
}

- (void)_createNotNeedToSrollToCenterBtns
{
    if (_itemButtons.count == 0) {
        return;
    }
    
    UIButton *lastBtn = _itemButtons.lastObject;
    CGFloat tailMaxX = 0;
    CGFloat tailMinX = 0;
    if ((lastBtn.frame.origin.x + kSTBLastItemRightPadding) > (STB_SCREEN_WIDTH - kSTBItemMoreWidth)) {
        tailMaxX = lastBtn.frame.origin.x + lastBtn.frame.size.width + kSTBLastItemRightPadding;
        tailMinX = tailMaxX - (STB_SCREEN_WIDTH * 0.5 - kSTBItemMoreWidth);
    } else {
        tailMaxX = lastBtn.frame.origin.x + lastBtn.frame.size.width + kSTBLastItemRightPadding;
        tailMinX = STB_SCREEN_WIDTH * 0.5;
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
