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
@property (nonatomic, strong) KKSegmentControlBaseLayout *layout;

@end

@implementation KKSegmentControlHeadVC

- (instancetype)initWithItemTitles:(NSMutableArray *)itemTitles
                            layout:(KKSegmentControlBaseLayout *)layout {
    if (self = [super init]) {
        _itemTitles = itemTitles;
        _layout = layout;
        
        _itemButtons = [NSMutableArray array];
        [self createSubviews];
        [self _autoLayoutSubviews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.view.backgroundColor = SegmentControl_HeaderBackgroundColor;
    
    _itemsScrollView.contentSize = CGSizeMake(self.itemScrollViewContentW + kScreenWidth * 0.1, 0);
    [self createNotNeedToSrollToCenterBtns];
    
    // 是否显示滑块
    BOOL isShowItemLine = YES;
    if ([self.delegate respondsToSelector:@selector(isShowItemLineForSegmentControlHeadVC:)]) {
        isShowItemLine = [self.delegate isShowItemLineForSegmentControlHeadVC:self];
    }
    _itemLine.hidden = !isShowItemLine;
}


- (void)createSubviews {
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_containerView];
    
    _itemsScrollView = [[UIScrollView alloc] init];
    _itemsScrollView.backgroundColor = [UIColor clearColor];
    _itemsScrollView.showsHorizontalScrollIndicator = NO;
    _itemsScrollView.showsVerticalScrollIndicator = NO;
    _itemsScrollView.bounces = NO;
    _itemsScrollView.scrollEnabled = self.layout.itemScrollViewScrollEnable;
    [_containerView addSubview:_itemsScrollView];
    
    [self _createItems];
    
    _itemMore = [UIButton buttonWithType:UIButtonTypeCustom];
    [_itemMore setTitle:@"更多" forState:UIControlStateNormal];
    _itemMore.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_itemMore.titleLabel setFont:[UIFont systemFontOfSize:SegmentControl_HeaderItemFontSize]];
//    [_itemMore setTitleColor:kSTBColorWithHex(kSTBItemFontNormalColor) forState:UIControlStateNormal];
//    [_itemMore setTitleColor:kSTBColorWithHex(kSTBItemFontSelectedColor) forState:UIControlStateSelected];
    [_itemMore addTarget:self action:@selector(itemMoreClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_itemMore];
    
    _itemLine = [UIView new];
    _itemLine.backgroundColor = SegmentControl_HeaderSliderColor;
    CGFloat w = [self.layout lineWidthWithIndex:0];
    CGFloat h = 2;
    CGFloat x = SegmentControl_HeaderFirstItemLeftPadding - SegmentControl_HeaderItemLineLeftOverWidtht;
    CGFloat y = SegmentControl_HeaderViewHeight * SegmentControl_HeaderItemHeightRatio;
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
        make.edges.mas_equalTo(self.view);
    }];
    
    [_itemsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat widthOffset = -SegmentControl_HeaderItemMoreWidth;
        make.left.mas_equalTo(_containerView.mas_left);
        make.top.bottom.mas_equalTo(_containerView);
        make.width.mas_equalTo(_containerView.mas_width).offset(widthOffset);
    }];
    
    [_itemMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(_containerView);
        make.height.mas_equalTo(SegmentControl_HeaderItemHeightRatio * SegmentControl_HeaderViewHeight);
        make.width.mas_equalTo(SegmentControl_HeaderItemMoreWidth);
    }];
}

- (CGFloat)itemScrollViewContentW {
    _itemScrollViewContentW = 0;
    for (NSNumber *value in self.layout.itemStringWidths) {
        _itemScrollViewContentW += [value floatValue];
    }
    _itemScrollViewContentW += (_itemTitles.count - 1) * SegmentControl_HeaderItemHorizontalSpace;
    return _itemScrollViewContentW;
}

- (void)createNotNeedToSrollToCenterBtns {
    if (_itemButtons.count == 0) {
        return;
    }
    
    UIButton *lastBtn = _itemButtons.lastObject;
    CGFloat tailMaxX = 0;
    CGFloat tailMinX = 0;
    CGFloat width = self.view.bounds.size.width;
    
    if ((lastBtn.frame.origin.x + SegmentControl_HeaderLastItemRightPadding) > (width - SegmentControl_HeaderItemMoreWidth)) {
        tailMaxX = lastBtn.frame.origin.x + lastBtn.frame.size.width + SegmentControl_HeaderLastItemRightPadding;
        tailMinX = tailMaxX - (width * 0.5 - SegmentControl_HeaderItemMoreWidth);
    } else {
        tailMaxX = lastBtn.frame.origin.x + lastBtn.frame.size.width + SegmentControl_HeaderLastItemRightPadding;
        tailMinX = width * 0.5;
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
    [self autoScrollItemsScrollViewFromIndex:from toIndex:to animate:YES];
    
    if (from != to) {
        if ([self.delegate respondsToSelector:@selector(segmentControlHeadVC:itemChangedFromIndex:toIndex:)]) {
            [self.delegate segmentControlHeadVC:self itemChangedFromIndex:from toIndex:to];
        }
    }
}

- (void)autoScrollItemsScrollViewFromIndex:(NSUInteger)from
                                   toIndex:(NSUInteger)to
                                   animate:(BOOL)animate {
    // 最左边不需要滚动的按钮
    CGFloat totalW = self.view.bounds.size.width;
    
    UIButton *lastBtn = _itemButtons.lastObject;
    if ((lastBtn.frame.origin.x + lastBtn.frame.size.width) < (totalW - SegmentControl_HeaderItemMoreWidth - SegmentControl_HeaderLastItemRightPadding)) {
        return;
    }
    
    UIButton *btnTo = _itemButtons[to];
    [self _updateItemLineWithButton:btnTo animate:YES];
    [self _updateItemButtonWithButton:btnTo];
    
    CGFloat screenCenterX = totalW * 0.5;
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
            CGFloat tailX = lastBtn.frame.origin.x + lastBtn.frame.size.width + SegmentControl_HeaderLastItemRightPadding - (totalW - SegmentControl_HeaderItemMoreWidth);
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
                _itemLine.frame = CGRectMake(SegmentControl_HeaderFirstItemLeftPadding - SegmentControl_HeaderItemLineLeftOverWidtht, lineY, lineW, lineH);
            }
        } completion:nil];
    } else {
        if (button.center.x > 0) {
            _itemLine.frame = CGRectMake(lineX, lineY, lineW, lineH);
            CGPoint center = CGPointMake(button.center.x, _itemLine.center.y);
            _itemLine.center = center;
        } else {
            _itemLine.frame = CGRectMake(SegmentControl_HeaderFirstItemLeftPadding - SegmentControl_HeaderItemLineLeftOverWidtht, lineY, lineW, lineH);
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
