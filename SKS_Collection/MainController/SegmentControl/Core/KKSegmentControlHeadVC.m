//
//  KKSegmentControlHeadVC.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/11/21.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "KKSegmentControlHeadVC.h"
#import "KKSegmentControlLayoutAuto.h"
#import "KKSegmentControlLayoutBisect.h"
#import "UIView+Frame.h"

@interface KKSegmentControlHeadVC ()
{
    UIView          *_containerView;
    UIScrollView    *_itemsScrollView;
    UIButton        *_itemMore;
    UIView          *_slide;
    
    UIButton        *_selectedItem;
    
    NSMutableArray<UIButton *>  *_itemButtons;
    NSMutableArray<UIButton *>  *_notNeedToSrollToCenterBtns;
    NSArray<NSString *>  *_itemTitles;
    
    CGFloat _slideBegainCenterX;
    
    NSInteger _viewAppearCount;
}

@property (nonatomic, assign) CGFloat itemScrollViewContentW;

@end

@implementation KKSegmentControlHeadVC

- (instancetype)initWithItemTitles:(NSMutableArray *)itemTitles
                            layout:(KKSegmentControlBaseLayout *)layout {
    if (self = [super init]) {
        _itemTitles = itemTitles;
        _layout = layout;
        _viewAppearCount = 0;
        _itemButtons = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createSubviews];
    [self autoLayoutSubviews];
    
    [self setupTransform];
}
    
- (void)setupTransform {
    if (_itemButtons.count > 0) {
        
        [self updateItemButtonWithButton:_itemButtons.firstObject];
        
        // slide
        CGFloat scaleX = self.layout.config.slideTransformScaleX;
        CGFloat scaleY = self.layout.config.slideTransformScaleY;
        _slide.transform = CGAffineTransformMakeScale(scaleX, scaleY);
    }
}
    
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _viewAppearCount++;
    if (_viewAppearCount == 1) { // 首次进入
        self.view.backgroundColor = self.layout.config.headerBackgroundColor;
        
        _itemsScrollView.contentSize = CGSizeMake(self.itemScrollViewContentW + kScreenWidth * 0.1, 0);
        
        [self createNotNeedToSrollToCenterBtns];
        
        // 是否显示滑块
        BOOL isShowSlide = self.layout.config.isShowSlide;
        _slide.hidden = !isShowSlide;
        _slideBegainCenterX = _slide.kk_centerX;
    }
}


- (void)createSubviews {
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_containerView];
    
    _itemsScrollView = [[UIScrollView alloc] init];
    _itemsScrollView.backgroundColor = [UIColor clearColor];
    _itemsScrollView.showsHorizontalScrollIndicator = NO;
    _itemsScrollView.showsVerticalScrollIndicator = NO;
    _itemsScrollView.bounces = YES;
    _itemsScrollView.scrollEnabled = self.layout.itemScrollViewScrollEnable;
    [_containerView addSubview:_itemsScrollView];
    
    [self createItems];
    
    _itemMore = [UIButton buttonWithType:UIButtonTypeCustom];
    [_itemMore setTitle:@"更多" forState:UIControlStateNormal];
    _itemMore.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_itemMore.titleLabel setFont:[UIFont systemFontOfSize:self.layout.config.itemFontSize]];
//    [_itemMore setTitleColor:kSTBColorWithHex(kSTBItemFontNormalColor) forState:UIControlStateNormal];
//    [_itemMore setTitleColor:kSTBColorWithHex(kSTBItemFontSelectedColor) forState:UIControlStateSelected];
    [_itemMore addTarget:self action:@selector(itemMoreClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_itemMore];
    
    _slide = [UIView new];
    _slide.backgroundColor = self.layout.config.sliderColor;
    [_itemsScrollView addSubview:_slide];
}

- (void)createItems {
    [_itemTitles enumerateObjectsUsingBlock:^(NSString *titleString, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemButton addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [itemButton setTitle:self->_itemTitles[idx] forState:UIControlStateNormal];
        itemButton.tag = idx;
        
        [self->_itemsScrollView addSubview:itemButton];
        
        [self->_itemButtons addObject:itemButton];
    }];
    
    [self.layout layoutItemsViews:_itemButtons];
}

- (void)autoLayoutSubviews {
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [_itemsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat widthOffset = -self.layout.config.itemMoreWidth;
        make.left.mas_equalTo(self->_containerView.mas_left);
        make.top.bottom.mas_equalTo(self->_containerView);
        make.width.mas_equalTo(self->_containerView.mas_width).offset(widthOffset);
    }];
    
    [_itemMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self->_containerView);
        make.height.mas_equalTo(self.layout.config.itemHeightRatio * self.layout.config.headerViewHeight);
        make.width.mas_equalTo(self.layout.config.itemMoreWidth);
    }];
    
    if (!_itemButtons || _itemButtons.count == 0) {
        return;
    }
    
    CGFloat w = [self.layout lineWidthWithIndex:0];
    CGFloat h = self.layout.config.slideHeight;
    CGFloat topPadding = self.layout.config.slideTopPaddingForItem;
    // 滑块在顶部时
    SegmentControlSlidePosition posion = self.layout.config.slidePosition;
    if (posion == SegmentControlSlidePositionTop) {
        [_slide mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(w);
            make.height.mas_equalTo(h);
            make.centerX.mas_equalTo(self->_itemButtons.firstObject.mas_centerX);
            make.top.mas_equalTo(self.view);
        }];
    } else {
        [_slide mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(w);
            make.height.mas_equalTo(h);
            make.centerX.mas_equalTo(self->_itemButtons.firstObject.mas_centerX);
            make.top.mas_equalTo(self->_itemButtons.firstObject.mas_bottom).offset(topPadding);
        }];
    }
}

- (CGFloat)itemScrollViewContentW {
    _itemScrollViewContentW = 0;
    for (NSNumber *value in self.layout.itemStringWidths) {
        _itemScrollViewContentW += [value floatValue];
    }
    _itemScrollViewContentW += (_itemTitles.count - 1) * self.layout.config.itemHorizontalSpace;
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
    
    if ((lastBtn.frame.origin.x + self.layout.config.lastItemRightPadding) > (width - self.layout.config.itemMoreWidth)) {
        tailMaxX = lastBtn.frame.origin.x + lastBtn.frame.size.width + self.layout.config.lastItemRightPadding;
        tailMinX = tailMaxX - (width * 0.5 - self.layout.config.itemMoreWidth);
    } else {
        tailMaxX = lastBtn.frame.origin.x + lastBtn.frame.size.width + self.layout.config.lastItemRightPadding;
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
    UIButton *btnTo = _itemButtons[to];
    [self updateSlideWithButton:btnTo animate:YES];
    [self updateItemButtonWithButton:btnTo];

    // 最左边不需要滚动的按钮
    CGFloat totalW = self.view.bounds.size.width;
    UIButton *lastBtn = _itemButtons.lastObject;
    if ((lastBtn.frame.origin.x + lastBtn.frame.size.width) < (totalW - self.layout.config.itemMoreWidth - self.layout.config.lastItemRightPadding)) {
        return;
    }
    
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
            CGFloat tailX = lastBtn.frame.origin.x + lastBtn.frame.size.width + self.layout.config.lastItemRightPadding - (totalW - self.layout.config.itemMoreWidth);
            [_itemsScrollView setContentOffset:CGPointMake(tailX, contentOffsetY) animated:animate];
        }
    }
}

- (void)updateSlideWithButton:(UIButton *)button animate:(BOOL)animate {
    if (!_itemButtons || _itemButtons.count == 0) {
        return;
    }

    CGFloat lineW = [self.layout lineWidthWithIndex:button.tag];
    CGFloat deltaCenterX = button.kk_centerX - _slideBegainCenterX;
    [_slide mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(lineW);
        make.centerX.mas_equalTo(self->_itemButtons.firstObject.mas_centerX).offset(deltaCenterX);
    }];
    [_slide setNeedsLayout];

    if (animate) {
        _slide.transform = CGAffineTransformIdentity;
        
        [UIView animateWithDuration:0.33 animations:^{
            [self.view layoutIfNeeded];
            
            CGFloat scaleX = self.layout.config.slideTransformScaleX;
            CGFloat scaleY = self.layout.config.slideTransformScaleY;
            self->_slide.transform = CGAffineTransformMakeScale(scaleX, scaleY);
            
        } completion:^(BOOL finished) {
        }];
    } else {
        [self.view layoutIfNeeded];
    }
}

- (void)updateItemButtonWithButton:(UIButton *)button {
    _selectedItem.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:0.33 animations:^{
        CGFloat scaleX = self.layout.config.itemSelectedTransformScaleX;
        CGFloat scaleY = self.layout.config.itemSelectedTransformScaleY;
        button.transform = CGAffineTransformMakeScale(scaleX, scaleY);
    }];
    
    _selectedItem.selected = NO;
    button.selected = YES;
    _selectedItem = button;
}

@end
