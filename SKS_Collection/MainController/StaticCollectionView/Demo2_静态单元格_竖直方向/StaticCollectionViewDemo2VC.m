//
//  StaticCollectionViewDemoVC.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "StaticCollectionViewDemo2VC.h"
#import "StaticCollectionView.h"
#import "CommonMacro.h"

#import "StaticCollectionViewDemo2Cell.h"

@interface StaticCollectionViewDemo2VC ()

@end

@implementation StaticCollectionViewDemo2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    StaticCollectionViewCellItem *item1 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"optimizest" title:@"最优策略" handle:^(StaticCollectionViewCell *cell, UIImageView *icon, UILabel *title){
        NSLog(@"最优策略");
    }];

    StaticCollectionViewCellItem *item2 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"KLine" title:@"相似K线" handle:^(StaticCollectionViewCell *cell, UIImageView *icon, UILabel *title){
        NSLog(@"相似K线");
    }];
    StaticCollectionViewCellItem *item3 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"alert" title:@"添加预警" handle:^(StaticCollectionViewCell *cell, UIImageView *icon, UILabel *title){
        NSLog(@"添加预警");
    }];
    StaticCollectionViewCellItem *item4 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"forecast" title:@"股价预测" handle:^(StaticCollectionViewCell *cell, UIImageView *icon, UILabel *title){
        NSLog(@"股价预测");
    }];
    StaticCollectionViewCellItem *item5 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"share" title:@"更多分享" handle:^(StaticCollectionViewCell *cell, UIImageView *icon, UILabel *title){
        NSLog(@"更多分享");
    }];
    
    StaticCollectionViewCellItem *item6 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"evaluate" title:@"优品评测" handle:^(StaticCollectionViewCell *cell, UIImageView *icon, UILabel *title){
        NSLog(@"优品评测");
    }];
    
    
    NSArray *array = @[item1, item2, item3, item4, item5, item6];
    
    // 多排显示
    UICollectionViewFlowLayout *flowLayout = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.headerReferenceSize = CGSizeMake(0, 25);
        layout.itemSize = CGSizeMake(kScreenWidth / 4, 100);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        layout;
    });
    
    CGRect frame = CGRectMake(0, 0, kScreenWidth, 300);
    StaticCollectionView *collectionView = [[StaticCollectionView alloc] initWithFrame:frame
                                                                                layout:flowLayout
                                                                          registerCell:[StaticCollectionViewDemo2Cell class]
                                                                             dataArray:array];
    
    collectionView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:collectionView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        item1.title = @"你是SB";
        [collectionView reloadData];
    });
}

@end
