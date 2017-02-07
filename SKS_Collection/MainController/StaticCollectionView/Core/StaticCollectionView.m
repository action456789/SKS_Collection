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

@interface StaticCollectionView()

@end

@implementation StaticCollectionView {
    
    UICollectionViewLayout *_layout;
}

static NSString * const reuseIdentifier = @"StaticCell";

- (instancetype)initWithFrame:(CGRect)frame layout:(UICollectionViewLayout *)layOut dataArray:(NSArray *)dataArray {
    if (self = [super initWithFrame:frame]) {
        
        _dataArray = dataArray;
        _layout = layOut;
        
        [self addSubview:self.collectionView];
    }
    return self;
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

- (void)reloadData {
    [self.collectionView reloadData];
}

# pragma mark - getter, setter 

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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StaticCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.dataModal = _dataArray[indexPath.row % _dataArray.count];
    cell.imageViewContentMode = self.imageViewContentMode;
    
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
