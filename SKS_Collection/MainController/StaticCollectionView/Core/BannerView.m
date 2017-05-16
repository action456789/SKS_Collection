//
//  BannerView.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/2/7.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "BannerView.h"
#import "StaticCollectionViewCell.h"
#import "StaticCollectionViewCellItem.h"
#import "Masonry.h"
#import "CommonMacro.h"

@interface BannerView() <UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation BannerView {
    UICollectionViewFlowLayout *_layout;
    NSInteger _totalItemsCount;
    NSInteger _currentIndex;
    NSTimer *_timer;
    BOOL _isAutoScroll;
}

static NSString * const reuseIdentifier = @"StaticCell";

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray autoScroll:(BOOL)autoScroll {
    
    UICollectionViewFlowLayout *flowLayout = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(frame.size.width, frame.size.height);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout;
    });
    
    if (self = [super initWithFrame:frame layout:flowLayout dataArray:dataArray]) {
        self.collectionView.pagingEnabled = YES;
        self.imageViewContentMode = UIViewContentModeScaleToFill;
        _totalItemsCount = dataArray.count * 3;
        _layout = flowLayout;
        _currentIndex = 0;
        _infiniteLoop = YES;
        _autoScrollTimeInterval = 2.0;
        
        if (autoScroll) {
            [self setupTimerWithTimeInterval:_autoScrollTimeInterval];
        }
        _isAutoScroll = autoScroll;
        
        [self setupPageControl];
    }
    
    return self;
}

- (void)setupPageControl {
    [self addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
    }];
}

- (void)setupTimerWithTimeInterval:(NSTimeInterval)interval {
    _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)autoScroll {
    NSInteger index = self.collectionView.contentOffset.x / _layout.itemSize.width;
    if (index == self.dataArray.count * 2) {
        index = self.dataArray.count;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)timerEvent {
    [self autoScroll];
}

- (void)invalidateTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - getter &&& setter

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval {
    _autoScrollTimeInterval = autoScrollTimeInterval;
    [self invalidateTimer];
    [self setupTimerWithTimeInterval:autoScrollTimeInterval];
}

- (NSInteger)currentIndex {
    NSInteger index = self.collectionView.contentOffset.x / _layout.itemSize.width;
    return index % self.dataArray.count;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages = self.dataArray.count;
        pageControl.userInteractionEnabled = NO;
        pageControl.currentPage = 0;
        _pageControl = pageControl;
    }
    return _pageControl;
}

#pragma mark - life circles

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.dataArray.count inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)dealloc {
    [self invalidateTimer];
    
    //解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
}

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StaticCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.dataModal = self.dataArray[indexPath.row % self.dataArray.count];
    cell.imageViewContentMode = self.imageViewContentMode;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    StaticCollectionViewCellItem *item = self.dataArray[indexPath.row % self.dataArray.count];
    if (item.clickedHandle) {
        item.clickedHandle(nil, nil, nil);
    }
}

#pragma mark <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.infiniteLoop) {
        CGFloat index = self.collectionView.contentOffset.x / _layout.itemSize.width;
        if (index == 1.0) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.dataArray.count + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        } else if (index == _totalItemsCount - 2) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.dataArray.count * 2 - 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        } else if (index <= 0.0) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.dataArray.count inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        } else if (index >= _totalItemsCount - 1) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.dataArray.count * 2 - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
    }
    
    self.pageControl.currentPage = self.currentIndex;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_isAutoScroll) {
        [self setupTimerWithTimeInterval:self.autoScrollTimeInterval];
    }
}

@end
