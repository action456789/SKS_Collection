//
//  MyBannerViewController.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/23.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "BanberDemoVC.h"
#import "BannerView.h"
#import "CommonMacro.h"
#import "BannerDemoCell.h"

@interface BanberDemoVC ()
@property (nonatomic, strong) BannerView *bannerView;
@end

@implementation BanberDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    StaticCollectionViewCellItem *item1 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"banner1" title:nil handle:^(StaticCollectionViewCell *cell, UIImageView *icon, UILabel *title){
        NSLog(@"banner1");
    }];
    
    StaticCollectionViewCellItem *item2 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"banner2" title:nil handle:^(StaticCollectionViewCell *cell, UIImageView *icon, UILabel *title){
        NSLog(@"banner2");
    }];
    
    StaticCollectionViewCellItem *item3 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"banner3" title:nil handle:^(StaticCollectionViewCell *cell, UIImageView *icon, UILabel *title){
        NSLog(@"banner3");
    }];
    
    NSArray *array = @[item1, item2, item3];
    
    BannerView *bannerView = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)
                                                  registerCell:[BannerDemoCell class]
                                                     dataArray:array
                                                    autoScroll:YES];
    [self.view addSubview:bannerView];
    self.bannerView = bannerView;
}


@end
