//
//  StaticCollectionViewDemoVC.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "StaticCollectionViewDemoVC.h"
#import "StaticCollectionView.h"
#import "StaticCollectionViewCellItem.h"
#import "CommonMacro.h"

@interface StaticCollectionViewDemoVC ()

@end

@implementation StaticCollectionViewDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [StaticCollectionViewCellItem alloc] initWithImageName:<#(NSString *)#> title:<#(NSString *)#>
    NSArray *array = @[StaticCellItem];
    
    StaticCollectionView *collectionView = [StaticCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) dataArray:<#(NSArray *)#>
}

@end
