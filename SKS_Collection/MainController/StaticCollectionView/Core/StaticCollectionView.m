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
    CGRect _frame;
    NSArray<StaticCollectionViewCellItem *> *_dataArray;
    UICollectionView *_collectionView;
}

static NSString * const reuseIdentifier = @"StaticCell";

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray {
    if (self = [super init]) {
        _dataArray = dataArray;
        
        _frame = frame;
        
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    
    UICollectionViewFlowLayout *flowLayout = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = self.cellSize;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout;
    });
    
    _collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:_frame collectionViewLayout:flowLayout];
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
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
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
