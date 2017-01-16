//
//  StaticCollectionView.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "StaticCollectionView.h"
#import "StaticCollectionViewCell.h"
#import <Masonry.h>

@interface StaticCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation StaticCollectionView {
    
    NSArray<StaticCollectionViewCellItem *> *_dataArray;
    UICollectionView *_collectionView;
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
    
    _collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        [collectionView registerClass:[StaticCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [self addSubview:collectionView];
        
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        collectionView;
    });
    
    [_collectionView reloadData];
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
    
    [cell setData:_dataArray[indexPath.row]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

@end
