//
//  RootViewController.m
//  SKS_Collection
//
//  Created by KeSen on 7/12/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "RootViewController.h"
#import "CoutdownBtnDemoVC.h"
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
#import "NumberIncresingVc.h"
#import "CheckMarkAnimVc.h"
#import "ExpandableViewController.h"
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
#import "StaticCollectionViewDemo2VC.h"
#import "ModalFromViewController.h"
#import "BanberDemoVC.h"
#import "EjectShrinkBtnsDemoVC.h"
#import "LightControlPannelVC.h"
#import "WeekSelectorVCDemo.h"
#import "ColorSliderDemoVC.h"
#import "TipsViewDemoVC.h"

// OC 使用 Swift 代码
#import "SKS_Collection-Swift.h"

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
    NSArray *items = @[ [StaticCellItem itemWithTitle:@" 1. 倒计时按钮" icon:nil objectClass:[CoutdownBtnDemoVC class]]
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
                        ,[StaticCellItem itemWithTitle:@"12. 静态单元格" icon:nil objectClass:[FeedBackViewController class]]
                        ,[StaticCellItem itemWithTitle:@"13. 数字增长动画" icon:nil objectClass:[NumberIncresingVc class]]
                        ,[StaticCellItem itemWithTitle:@"14. CALayer动画" icon:nil objectClass:[CheckMarkAnimVc class]]
                        ,[StaticCellItem itemWithTitle:@"15. 可展开的班级学生列表" icon:nil objectClass:[ExpandableViewController class]]
                        ,[StaticCellItem itemWithTitle:@"16. TipsView" icon:nil objectClass:[TipsViewDemoVC class]]
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
                        ,[StaticCellItem itemWithTitle:@"25. 静态CollectionViewCell demo1 无限循环View" icon:nil objectClass:[BanberDemoVC class]]
                        ,[StaticCellItem itemWithTitle:@"26. 静态CollectionViewCell demo2" icon:nil objectClass:[StaticCollectionViewDemo2VC class]]
                        ,[StaticCellItem itemWithTitle:@"27. 静态CollectionViewCell demo3" icon:nil objectClass:[StaticCollectionViewDemo3VC class]]
                        ,[StaticCellItem itemWithTitle:@"28. 自定义转场动画" icon:nil objectClass:[ModalFromViewController class]]
                        ,[StaticCellItem itemWithTitle:@"29. 弹性按钮" icon:nil objectClass:[EjectShrinkBtnsDemoVC class]]
                        ,[StaticCellItem itemWithTitle:@"30. 彩色滑块" icon:nil objectClass:[ColorSliderDemoVC class]]
                        ,[StaticCellItem itemWithTitle:@"31. 圆环控制动画控制器" icon:nil objectClass:[LightControlPannelVC class]]
                        ,[StaticCellItem itemWithTitle:@"32. 周选择器" icon:nil objectClass:[WeekSelectorVCDemo class]]
                        ];
    
    StaticCellItemGroup *group = [StaticCellItemGroup itemGroupWithItems:items];
    self.dataArray = @[group];
}

@end
