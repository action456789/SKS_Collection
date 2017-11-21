//
//  KKSegmentControlHeadVC.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/11/21.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "KKSegmentControlHeadVC.h"
#import "KKSlideTabBarLayoutAuto.h"
#import "KKSlideTabBarLayoutBisect.h"

@interface KKSegmentControlHeadVC ()
{
    UIView          *_containerView;
    UIScrollView    *_itemsScrollView;
    UIButton        *_itemMore;
    UIView          *_itemLine;
    
    UIButton        *_selectedItem;
    CGRect          _itemLinePreFrame;
    
    NSMutableArray<UIButton *>  *_itemButtons;
    NSMutableArray<UIButton *>  *_notNeedToSrollToCenterBtns;
    NSArray<NSString *>  *_itemTitles;
}

@property (nonatomic, assign) CGFloat itemScrollViewContentW;
@property (nonatomic, strong) KKSlideTabBarBaseLayout *layout;

@end

@implementation KKSegmentControlHeadVC

- (instancetype)initWithItemTitles:(NSMutableArray *)itemTitles
                            layout:(KKSlideTabBarBaseLayout *)layout {
    if (self = [super init]) {
        _itemTitles = itemTitles;
        _layout = layout;
        
        _itemButtons = [NSMutableArray array];
        [self createSubviews];
        [self _autoLayoutSubviews];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _itemsScrollView.contentSize = CGSizeMake(self.itemScrollViewContentW + STB_SCREEN_WIDTH * 0.1, 0);
    [self createNotNeedToSrollToCenterBtns];
}


- (void)createSubviews {
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = kSTBColorWithHex(kSTBBarBgColor);
    [self.view addSubview:_containerView];
    
    _itemsScrollView = [[UIScrollView alloc] init];
    _itemsScrollView.backgroundColor = kSTBColorWithHex(kSTBBarBgColor);
    _itemsScrollView.showsHorizontalScrollIndicator = NO;
    _itemsScrollView.showsVerticalScrollIndicator = NO;
    _itemsScrollView.bounces = NO;
    _itemsScrollView.scrollEnabled = self.layout.itemScrollViewScrollEnable;
    [_containerView addSubview:_itemsScrollView];
    
    [self _createItems];
    
    _itemMore = [UIButton buttonWithType:UIButtonTypeCustom];
    [_itemMore setTitle:@"更多" forState:UIControlStateNormal];
    _itemMore.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_itemMore.titleLabel setFont:[UIFont systemFontOfSize:kSTBItemFontSize]];
    [_itemMore setTitleColor:kSTBColorWithHex(kSTBItemFontColor) forState:UIControlStateNormal];
    [_itemMore setTitleColor:kSTBColorWithHex(kSTBItemLineBgColor) forState:UIControlStateSelected];
    [_itemMore addTarget:self action:@selector(itemMoreClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_itemMore];
    
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

- (void)_createItems {
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

- (void)_autoLayoutSubviews {
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(44);
        make.height.mas_equalTo(@(kSTBTopViewHeight));
    }];
    
    [_itemsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat widthOffset = -kSTBItemMoreWidth;
        make.left.mas_equalTo(_containerView.mas_left);
        make.top.bottom.mas_equalTo(_containerView);
        make.width.mas_equalTo(_containerView.mas_width).offset(widthOffset);
    }];
    
    [_itemMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(_containerView);
        make.height.mas_equalTo(kSTBItemHeightRatio * kSTBTopViewHeight);
        make.width.mas_equalTo(kSTBItemMoreWidth);
    }];
}

- (CGFloat)itemScrollViewContentW {
    _itemScrollViewContentW = 0;
    for (NSNumber *value in self.layout.itemStringWidths) {
        _itemScrollViewContentW += [value floatValue];
    }
    _itemScrollViewContentW += (_itemTitles.count - 1) * kSTBItemHorizontalSpace;
    return _itemScrollViewContentW;
}

- (void)createNotNeedToSrollToCenterBtns {
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

- (void)itemMoreClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(segmentControlHeadVC:itemMoreClicked:)]) {
        [self.delegate segmentControlHeadVC:self itemMoreClicked:sender];
    }
}

- (void)itemPressed:(UIButton *)sender {
    [self _updateItemLineWithButton:sender animate:YES];
    
    NSInteger from = _selectedItem.tag;
    NSInteger to = sender.tag;
    [self _autoScrollItemsScrollViewFromIndex:from toIndex:to animate:YES];
    
    if (from != to) {
        if ([self.delegate respondsToSelector:@selector(segmentControlHeadVC:itemChangedFromIndex:toIndex:)]) {
            [self.delegate segmentControlHeadVC:self itemChangedFromIndex:from toIndex:to];
        }
    }
}

- (void)_autoScrollItemsScrollViewFromIndex:(NSUInteger)from toIndex:(NSUInteger)to animate:(BOOL)animate {
    // 最左边不需要滚动的按钮
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

- (void)_updateItemLineWithButton:(UIButton *)button animate:(BOOL)animate {
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

- (void)_updateItemButtonWithButton:(UIButton *)button {
    _selectedItem.selected = NO;
    button.selected = YES;
    _selectedItem = button;
}

@end
