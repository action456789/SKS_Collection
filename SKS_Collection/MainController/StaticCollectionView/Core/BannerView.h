//
//  BannerView.h
//  SKS_Collection
//
//  Created by ke sen. on 2017/2/7.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "StaticCollectionView.h"

@interface BannerView : StaticCollectionView

- (instancetype)initWithFrame:(CGRect)frame
                 registerCell:(Class)cellClass
                    dataArray:(NSArray *)dataArray
                   autoScroll:(BOOL)autoScroll;

@property (nonatomic, assign, readonly) NSInteger currentIndex;

/** 自动滚动间隔时间,默认2s */
@property (nonatomic, assign) NSTimeInterval autoScrollTimeInterval;

/** 是否无限循环,默认Yes */
@property (nonatomic,assign) BOOL infiniteLoop;

@end
