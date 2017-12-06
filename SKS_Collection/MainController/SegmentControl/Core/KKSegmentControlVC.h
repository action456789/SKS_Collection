//
//  KKSegmentControlVC.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/11/21.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKSegmentControlBaseLayout;
@class KKSegmentControlVC;

@protocol KKSegmentControlVCDelegate <NSObject>

/**
 数据源：返回每页控制器
 @return UIViewController 及其子类
 */
- (__kindof UIViewController *)segmentControlVC:(KKSegmentControlVC *)segmentControl viewControllerForPageAtIndex:(NSInteger)index;

@end

@interface KKSegmentControlVC : UIViewController

@property (nonatomic, assign) id<KKSegmentControlVCDelegate> delegate;

/// init all items but the array of page controllers is nil
- (instancetype)initWithItemTitles:(NSMutableArray<NSString *> *)itemTitles
                            layout:(KKSegmentControlBaseLayout *)layout;

/// designated init, init all items and page controllers once a time
- (instancetype)initWithItemTitles:(NSMutableArray<NSString *> *)itemTitles
                       controllers:(NSMutableArray<__kindof UIViewController *> *)controllers
                            layout:(KKSegmentControlBaseLayout *)layout;

@end
