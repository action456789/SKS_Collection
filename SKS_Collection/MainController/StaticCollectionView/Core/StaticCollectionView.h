//
//  StaticCollectionView.h
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StaticCollectionViewCellItem.h"

@interface StaticCollectionView : UIView <UICollectionViewDelegate, UICollectionViewDataSource>

- (instancetype)initWithFrame:(CGRect)frame
                       layout:(UICollectionViewLayout *)layOut
                    dataArray:(NSArray *)dataArray;

- (instancetype)initWithFrame:(CGRect)frame
                       layout:(UICollectionViewLayout *)layOut
                 registerCell:(Class)cellClass
                    dataArray:(NSArray *)dataArray;

// 静态单元格
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong, readonly) NSArray<StaticCollectionViewCellItem *> *dataArray;

- (void)reloadData;

@end
