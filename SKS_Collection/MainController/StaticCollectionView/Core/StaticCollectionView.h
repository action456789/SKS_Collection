//
//  StaticCollectionView.h
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaticCollectionView : UIView

- (instancetype)initWithFrame:(CGRect)frame layout:(UICollectionViewLayout *)layOut dataArray:(NSArray *)dataArray;

@end
