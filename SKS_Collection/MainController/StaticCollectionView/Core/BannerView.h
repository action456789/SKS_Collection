//
//  BannerView.h
//  SKS_Collection
//
//  Created by ke sen. on 2017/2/7.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "StaticCollectionView.h"

@interface BannerView : StaticCollectionView

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray autoScroll:(BOOL)autoScroll;

@property (nonatomic, assign, readonly) NSInteger currentIndex;

@end
