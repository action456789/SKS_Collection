//
//  RootViewController.m
//  SKS_Collection
//
//  Created by KeSen on 7/12/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "RootViewController.h"
#import "CountDownButtonDemoVC.h"
#import "RotateAnimateViewController.h"
#import "KKSlideTabBarViewController.h"
#import "BlurEffectDemoController.h"
#import "FileCacheDemoController.h"
#import "DiskCacheSqlLiteDemoController.h"
#import "GradientLayerDemoController.h"
#import "GradientLayerDemo2Controller.h"
#import "QRCodeViewController.h"
#import "ShimmerDemeController.h"
#import "WKWebViewDemoController.h"
#import "StaticCellDemoViewController.h"
#import "NumberIncresingVc.h"
#import "CheckMarkAnimVc.h"
#import "ExpandableViewController.h"
#import "TipsView.h"
#import "GifDemoViewController.h"
#import "CaculaterViewController.h"
#import "SearchDemoController.h"
#import "AppleSystemServiceViewController.h"
#import "PhotoToolViewController.h"
#import "SAMKeychainDemoViewController.h"
#import "LocksDemoViewController.h"
#import "CommonMacro.h"
#import "AddClickAreaButtonDemeVC.h"
#import "CycleScrollViewDemoVC.h"
#import "EmptyContentTableViewController.h"
#import "StaticCollectionViewDemoVC.h"
#import "ModalFromViewController.h"
#import "BanberViewController.h"
#import "EjectShrinkBtnsDemoVC.h"

@interface RootViewController()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
}

- (void)initData
{
    __weak __typeof(self) weakSelf = self;
    
    NSArray *items = @[ [StaticCellItem itemWithTitle:@" 1. 倒计时按钮" icon:nil objectClass:[CountDownButtonDemoVC class]]
                        ,[StaticCellItem itemWithTitle:@"2. 转动动画的暂停与恢复" icon:nil objectClass:[RotateAnimateViewController class]]
                        ,[StaticCellItem itemWithTitle:@"3. Slide Tab Bar" icon:nil objectClass:[KKSlideTabBarViewController class]]
                        ,[StaticCellItem itemWithTitle:@"4. 模糊效果" icon:nil objectClass:[BlurEffectDemoController class]]
                        ,[StaticCellItem itemWithTitle:@"5. 文件缓存" icon:nil objectClass:[FileCacheDemoController class]]
                        ,[StaticCellItem itemWithTitle:@"6. sqlite缓存" icon:nil objectClass:[DiskCacheSqlLiteDemoController class]]
                        ,[StaticCellItem itemWithTitle:@"7. GradientLayer(渐变梯度图层)" icon:nil objectClass:[GradientLayerDemoController class]]
                        ,[StaticCellItem itemWithTitle:@"8. GradientLayer动画" icon:nil objectClass:[GradientLayerDemo2Controller class]]
                        ,[StaticCellItem itemWithTitle:@"9. 扫描二维码" icon:nil objectClass:[QRCodeViewController class]]
                        ,[StaticCellItem itemWithTitle:@"10. 辉光动画" icon:nil objectClass:[ShimmerDemeController class]]
                        ,[StaticCellItem itemWithTitle:@"11. WKWebView的加载过程" icon:nil objectClass:[WKWebViewDemoController class]]
                        ,[StaticCellItem itemWithTitle:@"12. 静态单元格" icon:nil objectClass:[StaticCellDemoViewController class]]
                        ,[StaticCellItem itemWithTitle:@"13. 数字增长动画" icon:nil objectClass:[NumberIncresingVc class]]
                        ,[StaticCellItem itemWithTitle:@"14. √ × 动画" icon:nil objectClass:[CheckMarkAnimVc class]]
                        ,[StaticCellItem itemWithTitle:@"15. 可展开的班级学生列表" icon:nil objectClass:[ExpandableViewController class]]
                        ,[StaticCellItem itemWithTitle:@"16. 弹出 tips view" icon:nil type:StaticCellTypeHandle handle:^{[weakSelf showTipsView];}]
                        ,[StaticCellItem itemWithTitle:@"17. 加载 gif 图片" icon:nil objectClass:[GifDemoViewController class]]
                        ,[StaticCellItem itemWithTitle:@"18. 链式编程-计算器" icon:nil objectClass:[CaculaterViewController class]]
                        ,[StaticCellItem itemWithTitle:@"19. UISearchController" icon:nil objectClass:[SearchDemoController class]]
                        ,[StaticCellItem itemWithTitle:@"20. 苹果系统服务" icon:nil objectClass:[AppleSystemServiceViewController class]]
                        ,[StaticCellItem itemWithTitle:@"21. 照片工具类" icon:nil objectClass:[PhotoToolViewController class]]
                        ,[StaticCellItem itemWithTitle:@"22. SAMKeychain" icon:nil objectClass:[SAMKeychainDemoViewController class]]
                        ,[StaticCellItem itemWithTitle:@"23. Locks" icon:nil objectClass:[LocksDemoViewController class]]
                        ,[StaticCellItem itemWithTitle:@"24. 增加按钮点击区域" icon:nil objectClass:[AddClickAreaButtonDemeVC class]]
                        ,[StaticCellItem itemWithTitle:@"25. 无限滚动" icon:nil objectClass:[CycleScrollViewDemoVC class]]
                        ,[StaticCellItem itemWithTitle:@"24. 无数据视图" icon:nil objectClass:[EmptyContentTableViewController class]]
                        ,[StaticCellItem itemWithTitle:@"25. 静态CollectionViewCell" icon:nil objectClass:[StaticCollectionViewDemoVC class]]
                        ,[StaticCellItem itemWithTitle:@"25. 自定义转场动画" icon:nil objectClass:[ModalFromViewController class]]
                        ,[StaticCellItem itemWithTitle:@"26. 启动引导图、无线循环View" icon:nil objectClass:[BanberViewController class]]
                        ,[StaticCellItem itemWithTitle:@"27. 弹性按钮" icon:nil objectClass:[EjectShrinkBtnsDemoVC class]]
                        ];
    
    StaticCellItemGroup *group = [StaticCellItemGroup itemGroupWithHeaderTitle:nil
                                                                  headerHeight:0
                                                                   footerTitle:nil
                                                                  footerHeight:0
                                                                         items:items];
    
    self.dataArray = @[group];
}

- (void)showTipsView
{
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor redColor];
    
    TipsView *tipsView = [[TipsView alloc] init];
    tipsView.showType = TipsViewShowTypeCenter;
    tipsView.contentView = contentView;
    tipsView.contentViewSize = CGSizeMake(kScreenWidth, 243);
    
    if (tipsView.isAnimating) {
        return;
    }
    
    [tipsView showInView:nil animatable:YES];
}

@end
