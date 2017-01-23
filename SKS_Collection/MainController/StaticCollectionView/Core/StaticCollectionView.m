//
//  StaticCollectionView.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "StaticCollectionView.h"
#import "StaticCollectionViewCell.h"
#import "StaticCollectionViewCellItem.h"
#import "Masonry.h"

@interface StaticCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation StaticCollectionView {
    
    NSArray<StaticCollectionViewCellItem *> *_dataArray;
    UICollectionViewLayout *_layout;
}

static NSString * const reuseIdentifier = @"StaticCell";

- (instancetype)initWithFrame:(CGRect)frame layout:(UICollectionViewLayout *)layOut dataArray:(NSArray *)dataArray {
    if (self = [super initWithFrame:frame]) {
        
        _dataArray = dataArray;
        _layout = layOut;
        
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    [self addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[StaticCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    return _collectionView;
}

// tell UIKit that you are using AutoLayout
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    //according to apple super should be called at end of method
    [super updateConstraints];
}

# pragma mark - getter, setter 

- (void)setPageEnable:(BOOL)pageEnable {
    self.collectionView.pagingEnabled = pageEnable;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StaticCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.dataModal = _dataArray[indexPath.row];
    cell.imageViewContentMode = self.imageViewContentMode;
    
    // 测试
    cell.backgroundColor = [UIColor grayColor];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    StaticCollectionViewCellItem *item = _dataArray[indexPath.row];
    if (item.clickedHandle) {
        item.clickedHandle();
    }
}

@end
